package com.ecommerce.karate;

import com.intuit.karate.junit5.Karate;
import org.junit.jupiter.api.Test;

/**
 * Single Page Application Test Runner
 */
class SimpleWorkingTestRunner {

    @Test
    void testEcommerceAPIs() {
        // Run all e-commerce feature files
        Karate.run("classpath:features").tags("~@ignore");
        
        // Generate single page application
        SinglePageGenerator.generateSinglePage();
        
        // Generate custom HTML report (for backup)
        ReportGenerator.generateHtmlReport();
    }
}
