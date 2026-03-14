package com.ecommerce.karate;

import com.intuit.karate.junit5.Karate;
import org.junit.jupiter.api.Test;

/**
 * Ultimate Test Runner for Karate API Tests
 * Simple solution that generates HTML reports using Karate's built-in functionality
 */
class UltimateTestRunner {

    @Test
    void testBasicKarate() {
        // Run basic test - Karate will auto-generate HTML reports
        Karate.run("classpath:features/basic/basic-test.feature");
    }
}
