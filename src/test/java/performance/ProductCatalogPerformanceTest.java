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
 * Performance test for product catalog operations using Karate Gatling integration
 */
public class ProductCatalogPerformanceTest extends Simulation {

    KarateProtocol protocol = PreDef.karateProtocol(
        Map.of("features/product-catalog/product-search.feature", 
            PreDef.pauseFor("get", 1, 2)
        )
    );

    {
        protocol.nameResolver = (requestName, context) -> {
            if (requestName.contains("products")) {
                return "Product Catalog";
            }
            return requestName;
        };
    }

    ScenarioBuilder scnProductList = scenario("Product List Load Test")
        .exec(
            PreDef.karateFeature("classpath:features/product-catalog/product-search.feature@Get all products list")
        );

    ScenarioBuilder scnProductSearch = scenario("Product Search Load Test")
        .exec(
            PreDef.karateFeature("classpath:features/product-catalog/product-search.feature@Search products by keyword")
        );

    ScenarioBuilder scnProductDetails = scenario("Product Details Load Test")
        .exec(
            PreDef.karateFeature("classpath:features/product-catalog/product-search.feature@Get product details by ID")
        );

    ScenarioBuilder scnProductFilter = scenario("Product Filter Load Test")
        .exec(
            PreDef.karateFeature("classpath:features/product-catalog/product-search.feature@Filter products by category")
        );

    ScenarioBuilder scnPagination = scenario("Pagination Load Test")
        .exec(
            PreDef.karateFeature("classpath:features/product-catalog/product-search.feature@Product pagination functionality")
        );

    {
        setUp(
            scnProductList.injectOpen(
                rampUsersPerSec(10).to(50).during(Duration.ofSeconds(30)),
                constantUsersPerSec(50).during(Duration.ofMinutes(3)),
                rampUsersPerSec(50).to(10).during(Duration.ofSeconds(30))
            ).protocols(protocol),
            
            scnProductSearch.injectOpen(
                rampUsersPerSec(5).to(25).during(Duration.ofSeconds(20)),
                constantUsersPerSec(25).during(Duration.ofMinutes(2))
            ).protocols(protocol),
            
            scnProductDetails.injectOpen(
                constantUsersPerSec(30).during(Duration.ofMinutes(2))
            ).protocols(protocol),
            
            scnProductFilter.injectOpen(
                rampUsersPerSec(3).to(15).during(Duration.ofSeconds(20)),
                constantUsersPerSec(15).during(Duration.ofMinutes(1))
            ).protocols(protocol),
            
            scnPagination.injectOpen(
                constantUsersPerSec(20).during(Duration.ofMinutes(1))
            ).protocols(protocol)
        ).assertions(
            global().responseTime().max().lt(4000),
            global().responseTime().mean().lt(1000),
            global().successfulRequests().percent().gt(99.0),
            global().requestsPerSec().gt(25.0)
        );
    }
}
