package petclinic.basic;

import static io.gatling.javaapi.core.CoreDsl.*;
import static io.gatling.javaapi.http.HttpDsl.*;

import java.io.IOException;

import java.time.Duration;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
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

import java.util.stream.IntStream;

public class CombinedSimulation extends Simulation {

    Faker faker = new Faker(new Locale("es"), new Random(42));

    private final static String URL = System.getProperty("url", "http://localhost:8080");
    private final static int MAX_USERS = Integer.getInteger("maxUsers", 50);
    private final static int SIMULATION_DURATION = Integer.getInteger("duration", 3600);
    private final static String WORKLOAD_TYPE = System.getProperty("workloadType", "static");
    private final static boolean LIMIT = Boolean.parseBoolean(System.getProperty("limit", "false"));
    

    HttpProtocolBuilder httpProtocol = http.baseUrl(URL).disableCaching();

    private static int BASIC_PET_LIMIT = 2;
    private static int GOLD_PET_LIMIT = 4;
    private static int PLATINUM_PET_LIMIT = 7;

    private static int BASIC_VADEMECUM_LIMIT = 1;
    private static int GOLD_VADEMECUM_LIMIT = 2;
    private static int PLATINUM_VADEMECUM_LIMIT = 4;

    private static Map<String, Integer> VADEMECUM_LIMITS_PER_USER = new HashMap<>();

    Map<String, String> sentHeaders = Map.of(
            "Authorization", "Bearer #{auth}",
            "Pricing-Token", "#{pricingToken}");

    private final List<UserCredentials> userCredentials = new CopyOnWriteArrayList<>();

    private List<String> SYMPTOM_QUERIES = new ArrayList<>(List.of(
        "Fever, loss of appetite, seizures",
        "Nasal discharge, excessive drooling ptyalism, constipation",
        "Increased urination polyuria, bloated abdomen, disorientation",
        "Vomiting, aggressive behavior, weakness or collapsing",
        "Pale gums, increased heart rate (tachycardia), itchy skin pruritus",
        "Hair loss alopecia, blood in stool, stiffness in joints",
        "Restlessness or pacing, bad breath halitosis, difficulty breathing dyspnea",
        "Excessive scratching of ears, lumps or masses, tremors",
        "Eye discharge, diarrhea, excessive barking or vocalization",
        "Sneezing, paralysis in limbs, difficulty urinating"
    ));

    // Define a method to execute a sequence n times if LIMIT is true
    private ChainBuilder repeatIfLimit(ChainBuilder chain, int n) {
        if (LIMIT) {
            return repeat(n).on(chain);
        } else {
            return chain;
        }
    }    

    public CombinedSimulation() {
        // Load user credentials from CSV at initialization
        loadUserCredentials("src/test/resources/user_credentials.csv");
        configureWorkload();
    }

    private void loadUserCredentials(String filePath) {
        try (BufferedReader br = new BufferedReader(new FileReader(filePath))) {
            br.readLine(); // Skip the header line
            List<UserCredentials> tempCredentials = new ArrayList<>();
            String line;
            while ((line = br.readLine()) != null && tempCredentials.size() < 200) {
                String[] fields = line.split(",");
                if (fields.length >= 3) { // Expecting 3 fields: username, password, pricingType
                    String username = fields[0].trim();
                    String password = fields[1].trim();
                    String pricingType = fields[2].trim();
                    tempCredentials.add(new UserCredentials(username, password, pricingType));
                    VADEMECUM_LIMITS_PER_USER.put(username, 0);
                }
            }
            // Shuffle the credentials before adding to the shared list
            Collections.shuffle(tempCredentials);
            userCredentials.addAll(tempCredentials);

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

    // Define the ChainBuilder for opening the vademecum
    ChainBuilder openVademecum = exec(session -> {
        // Retrieve the current user's username from the session
        String username = session.getString("username");
        
        // Get the current vademecum access count for this user
        Integer vademecumAccessCount = VADEMECUM_LIMITS_PER_USER.get(username);
        
        // Define the vademecum limit based on pricing type
        String pricingType = session.getString("pricingType");
        int vademecumLimit = 0;

        if ("BASIC".equals(pricingType)) {
            vademecumLimit = BASIC_VADEMECUM_LIMIT;
        } else if ("GOLD".equals(pricingType)) {
            vademecumLimit = GOLD_VADEMECUM_LIMIT;
        } else if ("PLATINUM".equals(pricingType)) {
            vademecumLimit = PLATINUM_VADEMECUM_LIMIT;
        }

        // If the user has already reached the vademecum limit, abort the chain
        if (vademecumAccessCount >= vademecumLimit) {
            // Mark the session to indicate that the action was aborted
            session.set("vademecumAborted", true);
        } else {
            // If the limit is not reached, increment the vademecum access count for the user
            VADEMECUM_LIMITS_PER_USER.put(username, vademecumAccessCount + 1);
        }

        return session;
    })
    // Conditionally execute the vademecum action only if it's not aborted
    .doIf(session -> !session.contains("vademecumAborted") || !session.getBoolean("vademecumAborted")).then(
        exec(session -> {
            // Generate a random index to pick a query from the list
            Random random = new Random();
            int randomIndex = random.nextInt(SYMPTOM_QUERIES.size());
            String randomSymptoms = SYMPTOM_QUERIES.get(randomIndex);
            
            // Store the randomly picked symptoms in the session
            return session.set("randomSymptoms", randomSymptoms);
        })
        .exec(
            http("Get in the vademecum")
                .get("/api/v1/vets/vademecum/illnesses")
                .headers(sentHeaders)
                .queryParam("symptoms", "#{randomSymptoms}")  // Use the random symptoms from the session
        )
    )
    // Optional: Log when the vademecum feature is aborted (for debugging purposes)
    .doIf(session -> session.contains("vademecumAborted")).then(
        exec(session -> {
            System.out.println("Vademecum access aborted for user: " + session.getString("username"));
            return session;
        })
    );

                            

    // Define a method to pick the simulation based on the user's pricing type
    private ChainBuilder pickSimulation = exec(session -> {
        return session;
    }).doIf(session -> "BASIC".equals(session.getString("pricingType"))).then(
        repeatIfLimit(exec(petListing, formData, savePet, petListing, deletePet, petListing), BASIC_PET_LIMIT)
    ).doIf(session -> "GOLD".equals(session.getString("pricingType"))).then(
        randomSwitch().on(
            percent(0.33).then(repeatIfLimit(exec(petListing, formData, savePet, petListing, deletePet, petListing), GOLD_PET_LIMIT)),
            percent(0.33).then(exec(petListing, formData, savePet, visitForm, registerVisit, petListing, deletePet, petListing)),
            percent(0.34).then(exec(petListing, openVademecum))
        )
    ).doIf(session -> "PLATINUM".equals(session.getString("pricingType"))).then(
        randomSwitch().on(
            percent(0.25).then(repeatIfLimit(exec(petListing, formData, savePet, petListing, deletePet, petListing), PLATINUM_PET_LIMIT)),
            percent(0.25).then(exec(petListing, formData, savePet, visitForm, registerVisit, petListing, deletePet, petListing)),
            percent(0.25).then(exec(petListing, formData, savePet, consultationForm, registerConsultation, enterConsultationChat, sendConsultation, petListing, deletePet, petListing)),
            percent(0.25).then(exec(petListing, openVademecum))
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
