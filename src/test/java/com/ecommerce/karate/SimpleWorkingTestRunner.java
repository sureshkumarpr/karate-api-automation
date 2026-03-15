package com.ecommerce.karate;

import com.intuit.karate.junit5.Karate;
import org.junit.jupiter.api.Test;

/**
 * Complete E-commerce Test Runner with Landing Page
 */
class SimpleWorkingTestRunner {

    @Test
    void testEcommerceAPIs() {
        // Run all e-commerce feature files
        Karate.run("classpath:features").tags("~@ignore");
        
        // Generate landing page
        LandingPageGenerator.generateLandingPage();
        
        // Generate custom HTML report
        ReportGenerator.generateHtmlReport();
    }
}
