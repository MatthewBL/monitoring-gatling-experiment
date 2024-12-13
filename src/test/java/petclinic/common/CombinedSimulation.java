package petclinic.common;

import static io.gatling.javaapi.core.CoreDsl.*;
import static io.gatling.javaapi.http.HttpDsl.*;

import java.io.IOException;

import java.time.Duration;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Random;
import java.util.concurrent.CopyOnWriteArrayList;

import com.github.javafaker.Faker;

import java.io.BufferedReader;
import java.io.FileReader;

import io.gatling.javaapi.core.*;
import io.gatling.javaapi.http.*;

public class CombinedSimulation extends Simulation {

    Faker faker = new Faker(new Locale("es"), new Random(42));

    private final static String URL = System.getProperty("url", "http://localhost:8080");
    private final static int MAX_USERS = Integer.getInteger("maxUsers", 50);
    private final static int SIMULATION_DURATION = Integer.getInteger("duration", 3600);
    private final static String WORKLOAD_TYPE = System.getProperty("workloadType", "static"); // New parameter

    HttpProtocolBuilder httpProtocol = http.baseUrl(URL).disableCaching();

    Map<String, String> sentHeaders = Map.of(
            "Authorization", "Bearer #{auth}",
            "Pricing-Token", "#{pricingToken}");

    private final List<UserCredentials> userCredentials = new CopyOnWriteArrayList<>();

    private List<String> ALL_SYMPTOMS = new ArrayList<>(List.of(
        "fever",
        "coughing",
        "sneezing",
        "vomiting",
        "diarrhea",
        "lethargy",
        "loss of appetite",
        "increased thirst polydipsia",
        "increased urination polyuria",
        "weight loss",
        "weight gain",
        "difficulty breathing dyspnea",
        "nasal discharge",
        "eye discharge",
        "redness in eyes conjunctivitis",
        "itchy skin pruritus",
        "hair loss alopecia",
        "skin rashes",
        "lumps or masses",
        "bad breath halitosis",
        "excessive drooling ptyalism",
        "pale gums",
        "bleeding gums",
        "difficulty walking or limping",
        "stiffness in joints",
        "swollen joints",
        "seizures",
        "tremors",
        "aggressive behavior",
        "depression-like behavior",
        "restlessness or pacing",
        "excessive barking or vocalization",
        "difficulty urinating",
        "blood in urine (hematuria)",
        "blood in stool",
        "constipation",
        "bloated abdomen",
        "painful abdomen",
        "increased heart rate (tachycardia)",
        "decreased heart rate (bradycardia)",
        "uncoordinated movements (ataxia)",
        "weakness or collapsing",
        "excessive scratching of ears",
        "head shaking",
        "foul odor from ears",
        "excessive panting",
        "loss of consciousness",
        "disorientation",
        "excessive licking of paws or body",
        "paralysis in limbs"
    ));
    private List<String> SYMPTOMS = new ArrayList<>();

    public CombinedSimulation() {
        // Load user credentials from CSV at initialization
        loadUserCredentials("src/test/resources/user_credentials.csv");
        configureWorkload();
    }

    private void loadUserCredentials(String filePath) {
        try (BufferedReader br = new BufferedReader(new FileReader(filePath))) {
            br.readLine();
            String line;
            while ((line = br.readLine()) != null && userCredentials.size() < 200) {
                String[] fields = line.split(",");
                if (fields.length >= 3) {  // Expecting 3 fields: username, password, pricingType
                    String username = fields[0].trim();
                    String password = fields[1].trim();
                    String pricingType = fields[2].trim();
                    userCredentials.add(new UserCredentials(username, password, pricingType));
                }
            }
        } catch (IOException e) {
            throw new RuntimeException("Failed to load user credentials from CSV file", e);
        }
    }

    // Struct for holding credentials with pricing plan
    private static class UserCredentials {
        String username;
        String password;
        String pricingType;

        UserCredentials(String username, String password, String pricingType) {
            this.username = username;
            this.password = password;
            this.pricingType = pricingType;
        }
    }

    // Helper function to safely get and release credentials
    private synchronized UserCredentials acquireUserCredentials() {
        if (userCredentials.isEmpty()) {
            throw new RuntimeException("No available user credentials for login.");
        }
        return userCredentials.remove(0);
    }

    private synchronized void releaseUserCredentials(UserCredentials credentials) {
        userCredentials.add(credentials);
    }
    
    // Login chain using loaded credentials
    private ChainBuilder login = exec(session -> {
        // Fetch a unique user credential for this session
        UserCredentials credentials = acquireUserCredentials();
        session.set("credentials", credentials);  // Store in session for later release
        
        return session.setAll(Map.of("username", credentials.username, "password", credentials.password, 
                                     "pricingType", credentials.pricingType));
    }).exec(http("Login")
        .post("/api/v1/auth/signin")
        .body(StringBody("{\"username\": \"#{username}\", \"password\": \"#{password}\"}"))
        .asJson()
        .check(jmesPath("id").saveAs("userId"),
            jmesPath("token").saveAs("auth"),
            jmesPath("pricingToken").saveAs("pricingToken")))
    .exec(session -> {
        // At the end of the session, release the credential back to the pool
        UserCredentials credentials = session.get("credentials");
        releaseUserCredentials(credentials);
        return session;
    });

    // "Pets" simulation chain (common to all users)
    ChainBuilder petListing = group("List my pets and their visits").on(exec(
        http("Get my pets").get("/api/v1/pets")
            .queryParam("userId", "#{userId}")
            .headers(sentHeaders),
        http("Get my pets visits").get("/api/v1/visits")
            .headers(sentHeaders)),
        pause(Duration.ofMillis(300)));

    ChainBuilder formData = exec(
        http("Prefill data in the pet register form").get("/api/v1/pets/types")
            .headers(sentHeaders)
            .check(jmesPath("[#{randomInt(0,6)}]").saveAs("type"))
        ).exec(session -> {
            String petName = faker.animal().name().replaceAll("[^a-zA-Z0-9]", "") + System.currentTimeMillis();
            return session.set("petName", petName);
        }).pause(Duration.ofMillis(300));  // Increased pause

    ChainBuilder savePet = exec(http("Save my pet").post("/api/v1/pets")
        .headers(sentHeaders)
        .body(ElFileBody("pet-registration.json")).asJson()
        .check(status().is(201), jmesPath("id").saveAs("petId")))
    .pause(Duration.ofMillis(300));
            

    ChainBuilder deletePet = exec(http("Delete recently added pet").delete("/api/v1/pets/#{petId}")
            .headers(sentHeaders));

    // "Visits" simulation chain (only for gold and platinum users)
    ChainBuilder visitForm = group("Visit form with loaded data").on(exec(
            http("Get details for my pet").get("/api/v1/pets/#{petId}")
                .headers(sentHeaders)
                .check(jsonPath("$").saveAs("pet")),
            http("Get vet information").get("/api/v1/vets")
                .headers(sentHeaders)
                .check(jmesPath("[0]").saveAs("vet"))),
            pause(Duration.ofMillis(300)));

    ChainBuilder registerVisit = exec(
            http("Book a visit for my pet").post("/api/v1/pets/#{petId}/visits")
                .headers(sentHeaders)
                .body(ElFileBody("visit.json"))
                .asJson(),
            pause(Duration.ofMillis(300)));

    // "Consultations" simulation chain (only for platinum users)
    ChainBuilder consultationForm = exec(http("Get my pets").get("/api/v1/pets")
            .asJson()
            .queryParam("userId", "#{userId}")
            .headers(sentHeaders)
            .check(jmesPath("[0]").saveAs("pet"),
                    jmesPath("[0].owner").saveAs("owner")));

    ChainBuilder registerConsultation = exec(http("Post consultation to the vet").post("/api/v1/consultations")
            .asJson()
            .headers(sentHeaders)
            .body(ElFileBody("consultation.json"))
            .check(jsonPath("$.id").saveAs("consultationId")));

    ChainBuilder enterConsultationChat = exec(
            http("Get in the consultation chat")
                .get("/api/v1/consultations/#{consultationId}/tickets")
                .headers(sentHeaders));

    ChainBuilder sendConsultation = exec(
            http("Send a message in the chat to the vet")
                .post("/api/v1/consultations/#{consultationId}/tickets")
                .asJson()
                .headers(sentHeaders)
                .body(ElFileBody("ticket.json")));

    // "Vademecum" simulation chain (only for gold and platinum users)
    ChainBuilder openVademecum = exec(
            http("Get in the vademecum")
                .get("/api/v1/vets/vademecum/illnesses")
                .headers(sentHeaders));

    ChainBuilder queryVademecum = exec(
        http("Query vademecum illnesses")
            .get("/api/v1/vets/vademecum/illnesses")
            .queryParam("symptoms", SYMPTOMS.get(0))
            .queryParam("symptoms", SYMPTOMS.get(1))
            .queryParam("symptoms", SYMPTOMS.get(2))
            .headers(sentHeaders));
            

    // Define a method to pick the simulation based on the user's pricing type
    private ChainBuilder pickSimulation = exec(session -> {
        String pricingType = session.getString("pricingType");
        session.set("randomValue", Math.random());
        Collections.shuffle(ALL_SYMPTOMS);
        SYMPTOMS = new ArrayList<>(ALL_SYMPTOMS.subList(0, 3));
        return session;
    }).doIf(session -> "BASIC".equals(session.getString("pricingType"))).then(
        exec(petListing, formData, savePet, petListing, deletePet, petListing)
    ).doIf(session -> "GOLD".equals(session.getString("pricingType"))).then(
        randomSwitch().on(
            percent(33.0).then(exec(petListing, formData, savePet, petListing, deletePet, petListing)),
            percent(33.0).then(exec(petListing, formData, savePet, visitForm, registerVisit, petListing)),
            percent(34.0).then(exec(petListing, openVademecum, queryVademecum))
        )
    ).doIf(session -> "PLATINUM".equals(session.getString("pricingType"))).then(
        randomSwitch().on(
            percent(25.0).then(exec(petListing, formData, savePet, petListing, deletePet, petListing)),
            percent(25.0).then(exec(petListing, formData, savePet, visitForm, registerVisit, petListing)),
            percent(25.0).then(exec(petListing, formData, savePet, consultationForm, registerConsultation, enterConsultationChat, sendConsultation)),
            percent(25.0).then(exec(petListing, openVademecum, queryVademecum))
        )
    );
    
    // Main Scenario without registration
    ScenarioBuilder concurrentOwners = scenario("Concurrent Owners Simulation")
        .exec(login)
        .during(Duration.ofSeconds(SIMULATION_DURATION)).on(exec(pickSimulation));

    ScenarioBuilder concurrentOwners2 = scenario("Concurrent Owners Simulation 2")
        .exec(login)
        .during(Duration.ofSeconds(SIMULATION_DURATION)).on(exec(pickSimulation));

    private void configureWorkload() {
        switch (WORKLOAD_TYPE.toLowerCase()) {
        case "static":
            setUp(concurrentOwners.injectClosed(
                constantConcurrentUsers(MAX_USERS).during(Duration.ofSeconds(SIMULATION_DURATION))
            )).protocols(httpProtocol);
            break;
                
        case "periodic":
            setUp(concurrentOwners.injectOpen(
                rampUsers(MAX_USERS/4).during(Duration.ofSeconds(SIMULATION_DURATION / 4)),
                nothingFor(Duration.ofSeconds(SIMULATION_DURATION / 12)),
                rampUsers(MAX_USERS/4).during(Duration.ofSeconds(SIMULATION_DURATION / 4)),
                nothingFor(Duration.ofSeconds(SIMULATION_DURATION / 12)),
                rampUsers(MAX_USERS/4).during(Duration.ofSeconds(SIMULATION_DURATION / 4)),
                nothingFor(Duration.ofSeconds(SIMULATION_DURATION / 12)),
                rampUsers(MAX_USERS/4).during(Duration.ofSeconds(SIMULATION_DURATION / 4))
            )).protocols(httpProtocol);
            break;
                
        case "peak":
            setUp(concurrentOwners.injectOpen(
                rampUsersPerSec(MAX_USERS/SIMULATION_DURATION).to(MAX_USERS).during(Duration.ofSeconds(SIMULATION_DURATION / 10))
            )).protocols(httpProtocol);
            break;
                
        case "unpredictable":
            setUp(concurrentOwners.injectOpen(
                rampUsersPerSec(0).to(MAX_USERS).during(Duration.ofSeconds(SIMULATION_DURATION / 10)).randomized()
            )).protocols(httpProtocol);
            break;
                
        case "constantchange":
            setUp(concurrentOwners.injectClosed(
                rampConcurrentUsers(0).to(MAX_USERS).during(Duration.ofSeconds(SIMULATION_DURATION))
            )).protocols(httpProtocol);
            break;
                
        case "variable":
            setUp(concurrentOwners.injectOpen(
                rampUsers(MAX_USERS).during(Duration.ofSeconds(SIMULATION_DURATION / 4)),
                nothingFor(Duration.ofSeconds(SIMULATION_DURATION / 12)),
                rampUsers(MAX_USERS).during(Duration.ofSeconds(SIMULATION_DURATION / 4)),
                nothingFor(Duration.ofSeconds(SIMULATION_DURATION / 12)),
                rampUsers(MAX_USERS).during(Duration.ofSeconds(SIMULATION_DURATION / 4)),
                nothingFor(Duration.ofSeconds(SIMULATION_DURATION / 12)),
                rampUsers(MAX_USERS).during(Duration.ofSeconds(SIMULATION_DURATION / 4)),
                rampUsersPerSec(0).to(MAX_USERS).during(Duration.ofSeconds(SIMULATION_DURATION / 10)),
                rampUsersPerSec(0).to(MAX_USERS).during(Duration.ofSeconds(SIMULATION_DURATION / 10)).randomized()
            ).andThen(
                concurrentOwners2.injectClosed(
                    constantConcurrentUsers(MAX_USERS).during(Duration.ofSeconds(SIMULATION_DURATION / 2)),
                    rampConcurrentUsers(0).to(MAX_USERS).during(Duration.ofSeconds(SIMULATION_DURATION / 2))
                )
            )
            ).protocols(httpProtocol);
            break;
                
        default:
            setUp(concurrentOwners.injectClosed(
                constantConcurrentUsers(MAX_USERS).during(Duration.ofSeconds(SIMULATION_DURATION))
            )).protocols(httpProtocol);
            break;
        }
    }
}
