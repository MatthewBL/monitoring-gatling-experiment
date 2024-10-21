package petclinic.common;

import static io.gatling.javaapi.core.CoreDsl.*;
import static io.gatling.javaapi.http.HttpDsl.*;

import java.time.Duration;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Random;

import com.github.javafaker.Faker;

import io.gatling.javaapi.core.*;
import io.gatling.javaapi.http.*;

public class CombinedSimulation extends Simulation {

    Faker faker = new Faker(new Locale("es"), new Random(42));

    private final static String URL = System.getProperty("url", "http://localhost:8080");
    private final static int CONCURRENT_USERS = Integer.getInteger("users", 10);
    private final static int SIMULATION_DURATION = Integer.getInteger("duration", 3600);  // Duration in seconds

    HttpProtocolBuilder httpProtocol = http.baseUrl(URL).disableCaching();

    Map<String, String> sentHeaders = Map.of(
            "Authorization", "Bearer #{auth}",
            "Pricing-Token", "#{pricingToken}");

    // Pricing type assignment logic
    private ChainBuilder assignPricingType = exec(session -> {
        double rand = Math.random();
        String pricingType;
        if (rand < 0.6) {
            pricingType = "basic";
        } else if (rand < 0.9) {
            pricingType = "gold";
        } else {
            pricingType = "platinum";
        }
        return session.set("pricingType", pricingType);
    });

    // Common chain: user registration
    ChainBuilder register = exec(session -> {
        String username = faker.name().firstName().replaceAll("[^a-zA-Z0-9]", "") + System.currentTimeMillis();
        return session.setAll(Map.of("firstName", faker.name().firstName(),
                "lastName", faker.name().lastName(),
                "address", faker.address().streetName(),
                "username", username  // Store unique username
            ));
    }).exec(http("Get clinics").get("/api/v1/clinics").asJson(),
            http("Registration").post("/api/v1/auth/signup")
                    .body(ElFileBody("#{pricingType}/registration.json")).asJson()
                    .check(status().is(200)));

    // Login chain
    ChainBuilder login = exec(http("Login")
            .post("/api/v1/auth/signin").body(ElFileBody("login.json"))
            .asJson().check(jmesPath("id").saveAs("userId"),
                    jmesPath("token").saveAs("auth"),
                    jmesPath("pricingToken").saveAs("pricingToken")));

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

    // Define a method to pick the simulation based on the user's pricing type
    private ChainBuilder pickSimulation = exec(session -> {
        String pricingType = session.getString("pricingType");
        session.set("randomValue", Math.random()); // Store random value in session for later use
        return session;
    }).doIf(session -> "basic".equals(session.getString("pricingType"))).then(
        // Basic users always get the "pets" simulation
        exec(petListing, formData, savePet, petListing, deletePet, petListing)
    ).doIf(session -> "gold".equals(session.getString("pricingType"))).then(
        // Gold users can either get "pets" or "visits" simulation
        randomSwitch().on(
            percent(50.0).then(exec(petListing, formData, savePet, petListing, deletePet, petListing)),
            percent(50.0).then(exec(petListing, formData, savePet, visitForm, registerVisit, petListing))
        )
    ).doIf(session -> "platinum".equals(session.getString("pricingType"))).then(
        // Platinum users can get one of "pets", "visits", or "consultations"
        randomSwitch().on(
            percent(33.0).then(exec(petListing, formData, savePet, petListing, deletePet, petListing)),
            percent(33.0).then(exec(petListing, formData, savePet, visitForm, registerVisit, petListing)),
            percent(34.0).then(exec(petListing, formData, savePet, consultationForm, registerConsultation, enterConsultationChat, sendConsultation))
        )
    );

    // Main scenario that repeats forever, assigning new roles each time a user completes a cycle
    ScenarioBuilder concurrentOwners = scenario("Concurrent Owners Simulation")
        .exec(assignPricingType) 
        .exec(register, login)
        .during(Duration.ofSeconds(SIMULATION_DURATION)).on(exec(pickSimulation));


    {
        setUp(concurrentOwners.injectOpen(atOnceUsers(CONCURRENT_USERS))) // Inject users all at once
                .protocols(httpProtocol)
                .maxDuration(Duration.ofSeconds(SIMULATION_DURATION));   // Stop simulation after the specified duration
    }
}
