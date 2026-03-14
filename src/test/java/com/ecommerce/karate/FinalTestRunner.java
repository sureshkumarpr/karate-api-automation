package com.ecommerce.karate;

import com.intuit.karate.junit5.Karate;
import org.junit.jupiter.api.Test;

/**
 * Final Test Runner for Karate API Tests
 * Simple, working solution that generates HTML reports
 */
class FinalTestRunner {

    @Test
    void testBasicKarate() {
        // Simple test that will generate HTML reports
        Karate.run("classpath:features/basic/basic-test.feature");
    }
}
