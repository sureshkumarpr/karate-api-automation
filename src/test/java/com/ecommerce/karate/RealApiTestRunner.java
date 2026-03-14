package com.ecommerce.karate;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import org.junit.jupiter.api.Test;

/**
 * Real API Test Runner with Pass/Fail Scenarios
 * Tests real endpoints and generates comprehensive report
 */
class RealApiTestRunner {

    @Test
    void testRealApiEndpoints() {
        // Run all feature files including real API tests
        Results results = Runner.path("classpath:features")
            .tags("~@ignore")
            .parallel(1);
        
        // Generate custom HTML report with real test results
        ReportGenerator.generateHtmlReport(results);
    }
}
