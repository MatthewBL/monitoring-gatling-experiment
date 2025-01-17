package petclinic.platinum;

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

public class ConsultationsManagementIndividualSimulation extends Simulation {

    Faker faker = new Faker(new Locale("es"), new Random(42));

    private final static String URL = System.getProperty("url", "http://localhost:8080");

    private final static int PLATINUM_ID = 91;
    

    HttpProtocolBuilder httpProtocol = http.baseUrl(URL).disableCaching();

    Map<String, String> sentHeaders = Map.of(
            "Authorization", "Bearer #{auth}",
            "Pricing-Token", "#{pricingToken}");

    private final List<UserCredentials> userCredentials = new CopyOnWriteArrayList<>();

    public ConsultationsManagementIndividualSimulation() {
        // Load user credentials from CSV at initialization
        loadUserCredentials("src/test/resources/user_credentials.csv");
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
                }
            }
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
        return userCredentials.get(PLATINUM_ID);
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
            jmesPath("pricingToken").saveAs("pricingToken")));

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

    
    // Main Scenario without registration
    ScenarioBuilder concurrentOwners = scenario("Concurrent Owners Simulation")
        .exec(login)
        .exec(petListing, formData, savePet, consultationForm, registerConsultation, enterConsultationChat, sendConsultation, petListing, deletePet, petListing);
}