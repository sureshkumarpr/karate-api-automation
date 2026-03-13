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
 * Performance test for checkout and order processing using Karate Gatling integration
 */
public class CheckoutPerformanceTest extends Simulation {

    KarateProtocol protocol = PreDef.karateProtocol(
        Map.of("features/checkout-orders/checkout-process.feature", 
            PreDef.pauseFor("post", 3, 5)
        )
    );

    {
        protocol.nameResolver = (requestName, context) -> {
            if (requestName.contains("checkout")) {
                return "Checkout Process";
            }
            return requestName;
        };
    }

    ScenarioBuilder scnCheckout = scenario("Checkout Load Test")
        .exec(
            PreDef.karateFeature("classpath:features/checkout-orders/checkout-process.feature@Complete checkout process with valid payment")
        );

    ScenarioBuilder scnOrderTracking = scenario("Order Tracking Load Test")
        .exec(
            PreDef.karateFeature("classpath:features/checkout-orders/order-management.feature@Order status tracking")
        );

    ScenarioBuilder scnOrderHistory = scenario("Order History Load Test")
        .exec(
            PreDef.karateFeature("classpath:features/checkout-orders/order-management.feature@Get user order history")
        );

    ScenarioBuilder scnPaymentValidation = scenario("Payment Validation Load Test")
        .exec(
            PreDef.karateFeature("classpath:features/checkout-orders/checkout-process.feature@Credit card validation")
        );

    {
        setUp(
            scnCheckout.injectOpen(
                rampUsersPerSec(1).to(5).during(Duration.ofSeconds(30)),
                constantUsersPerSec(5).during(Duration.ofMinutes(2)),
                rampUsersPerSec(5).to(1).during(Duration.ofSeconds(30))
            ).protocols(protocol),
            
            scnOrderTracking.injectOpen(
                rampUsersPerSec(3).to(15).during(Duration.ofSeconds(20)),
                constantUsersPerSec(15).during(Duration.ofMinutes(1))
            ).protocols(protocol),
            
            scnOrderHistory.injectOpen(
                constantUsersPerSec(10).during(Duration.ofMinutes(1))
            ).protocols(protocol),
            
            scnPaymentValidation.injectOpen(
                rampUsersPerSec(2).to(8).during(Duration.ofSeconds(20)),
                constantUsersPerSec(8).during(Duration.ofMinutes(1))
            ).protocols(protocol)
        ).assertions(
            global().responseTime().max().lt(8000),
            global().responseTime().mean().lt(3000),
            global().successfulRequests().percent().gt(95.0),
            global().requestsPerSec().gt(5.0)
        );
    }
}
