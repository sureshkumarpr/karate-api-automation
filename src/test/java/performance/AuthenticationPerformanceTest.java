package performance;

import com.intuit.karate.gatling.GatlingMavenTest;
import com.intuit.karate.gatling.KarateProtocol;
import com.intuit.karate.gatling.PreDef;
import io.gatling.javaapi.core.CoreDsl;
import io.gatling.javaapi.core.ScenarioBuilder;
import io.gatling.javaapi.core.Simulation;

import java.time.Duration;
import java.util.Map;

import static io.gatling.javaapi.core.CoreDsl.*;
import static io.gatling.javaapi.http.HttpDsl.*;

/**
 * Performance test for authentication operations using Karate Gatling integration
 */
public class AuthenticationPerformanceTest extends Simulation {

    KarateProtocol protocol = PreDef.karateProtocol(
        Map.of("features/authentication/login.feature", 
            PreDef.pauseFor("post", 1, 3)
        )
    );

    {
        protocol.nameResolver = (requestName, context) -> {
            if (requestName.contains("login")) {
                return "User Login";
            }
            return requestName;
        };
    }

    ScenarioBuilder scnLogin = scenario("User Login Load Test")
        .exec(
            PreDef.karateFeature("classpath:features/authentication/login.feature@Successful user login with valid credentials")
        );

    ScenarioBuilder scnConcurrentLogin = scenario("Concurrent Login Test")
        .exec(
            PreDef.karateFeature("classpath:features/authentication/login.feature@Concurrent login requests performance test")
        );

    ScenarioBuilder scnRegistration = scenario("User Registration Load Test")
        .exec(
            PreDef.karateFeature("classpath:features/authentication/user-registration.feature@Successful user registration with valid data")
        );

    ScenarioBuilder scnTokenValidation = scenario("Token Validation Load Test")
        .exec(
            PreDef.karateFeature("classpath:features/authentication/login.feature@Token validation and session expiry")
        );

    {
        setUp(
            scnLogin.injectOpen(
                rampUsersPerSec(5).to(20).during(Duration.ofSeconds(30)),
                constantUsersPerSec(20).during(Duration.ofMinutes(2)),
                rampUsersPerSec(20).to(5).during(Duration.ofSeconds(30))
            ).protocols(protocol),
            
            scnConcurrentLogin.injectOpen(
                atOnceUsers(50)
            ).protocols(protocol),
            
            scnRegistration.injectOpen(
                rampUsersPerSec(1).to(5).during(Duration.ofSeconds(20)),
                constantUsersPerSec(5).during(Duration.ofMinutes(1))
            ).protocols(protocol),
            
            scnTokenValidation.injectOpen(
                constantUsersPerSec(15).during(Duration.ofMinutes(1))
            ).protocols(protocol)
        ).assertions(
            global().responseTime().max().lt(3000),
            global().responseTime().mean().lt(1500),
            global().successfulRequests().percent().gt(98.0),
            global().requestsPerSec().gt(15.0)
        );
    }
}
