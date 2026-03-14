package com.ecommerce.karate;

import com.intuit.karate.junit5.Karate;
import org.junit.jupiter.api.Test;

/**
 * Complete Test Runner for Karate API Tests
 * Runs tests and generates custom HTML report
 */
class CompleteTestRunner {

    @Test
    void testBasicKarate() {
        // Run basic test
        Karate.run("classpath:features/basic/basic-test.feature");
        
        // Generate custom HTML report after test execution
        ReportGenerator.generateHtmlReport();
    }
}
