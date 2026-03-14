package com.ecommerce.karate;

import com.intuit.karate.junit5.Karate;
import org.junit.jupiter.api.Test;

/**
 * Simple Working Test Runner with Landing Page
 */
class SimpleWorkingTestRunner {

    @Test
    void testBasicKarate() {
        // Run only basic test to check if framework works
        Karate.run("classpath:features/basic/basic-test.feature").tags("~@ignore");
        
        // Generate landing page
        LandingPageGenerator.generateLandingPage();
        
        // Generate custom HTML report
        ReportGenerator.generateHtmlReport();
    }
}
