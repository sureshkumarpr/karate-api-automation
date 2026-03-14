package com.ecommerce.karate;

import com.intuit.karate.junit5.Karate;
import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import org.junit.jupiter.api.Test;

/**
 * Working Test Runner for Karate API Tests
 * This class ensures HTML reports are generated properly
 */
class WorkingTestRunner {

    @Test
    void testBasicKarate() {
        // Run basic test with explicit HTML report generation
        Results results = Runner.path("classpath:features/basic/basic-test.feature")
            .tags("~@ignore")
            .parallel(1);
        
        // Generate HTML report
        results.reportDir("target/karate-reports");
    }
}
