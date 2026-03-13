package performance;

import com.intuit.karate.gatling.GatlingMavenTest;
import com.intuit.karate.gatling.KarateProtocol;
import com.intuit.karate.gatling.PreDef;
import io.gatling.javaapi.core.CoreDsl;
import io.gatling.javaapi.core.ScenarioBuilder;
import io.gatling.javaapi.core.Simulation;
import io.gatling.javaapi.http.HttpDsl;

import java.time.Duration;
import java.util.Map;

import static io.gatling.javaapi.core.CoreDsl.*;
import static io.gatling.javaapi.http.HttpDsl.*;

/**
 * Performance test for shopping cart operations using Karate Gatling integration
 */
public class CartPerformanceTest extends Simulation {

    KarateProtocol protocol = PreDef.karateProtocol(
        Map.of("features/shopping-cart/cart-operations.feature", 
            PreDef.pauseFor("get", 1, 2),
            PreDef.pauseFor("post", 2, 3),
            PreDef.pauseFor("put", 1, 2),
            PreDef.pauseFor("delete", 1, 2)
        )
    );

    {
        protocol.nameResolver = (requestName, context) -> {
            if (requestName.contains("cart")) {
                return "Cart Operations";
            }
            return requestName;
        };
    }

    ScenarioBuilder scnAddToCart = scenario("Add to Cart Load Test")
        .exec(
            PreDef.karateFeature("classpath:features/shopping-cart/cart-operations.feature@Add item to cart")
        );

    ScenarioBuilder scnViewCart = scenario("View Cart Load Test")
        .exec(
            PreDef.karateFeature("classpath:features/shopping-cart/cart-operations.feature@Get user cart (empty cart)")
        );

    ScenarioBuilder scnUpdateCart = scenario("Update Cart Load Test")
        .exec(
            PreDef.karateFeature("classpath:features/shopping-cart/cart-operations.feature@Update cart item quantity")
        );

    ScenarioBuilder scnCompleteFlow = scenario("Complete Cart Flow")
        .exec(
            PreDef.karateFeature("classpath:features/shopping-cart/cart-operations.feature@View cart with multiple items")
        );

    {
        setUp(
            scnAddToCart.injectOpen(
                rampUsersPerSec(1).to(5).during(Duration.ofSeconds(30)),
                constantUsersPerSec(5).during(Duration.ofMinutes(2)),
                rampUsersPerSec(5).to(1).during(Duration.ofSeconds(30))
            ).protocols(protocol),
            
            scnViewCart.injectOpen(
                rampUsersPerSec(2).to(10).during(Duration.ofSeconds(30)),
                constantUsersPerSec(10).during(Duration.ofMinutes(1)),
                rampUsersPerSec(10).to(2).during(Duration.ofSeconds(30))
            ).protocols(protocol),
            
            scnUpdateCart.injectOpen(
                rampUsersPerSec(1).to(3).during(Duration.ofSeconds(20)),
                constantUsersPerSec(3).during(Duration.ofMinutes(1)),
                rampUsersPerSec(3).to(1).during(Duration.ofSeconds(20))
            ).protocols(protocol),
            
            scnCompleteFlow.injectOpen(
                rampUsersPerSec(0.5).to(2).during(Duration.ofSeconds(20)),
                constantUsersPerSec(2).during(Duration.ofMinutes(1))
            ).protocols(protocol)
        ).assertions(
            global().responseTime().max().lt(5000),
            global().responseTime().mean().lt(2000),
            global().successfulRequests().percent().gt(95.0),
            global().requestsPerSec().gt(10.0)
        );
    }
}
