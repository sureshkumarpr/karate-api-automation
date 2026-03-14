package com.ecommerce.karate;

import com.intuit.karate.junit5.Karate;
import org.junit.jupiter.api.Test;

/**
 * Basic Test Runner for Karate API Tests
 * This class runs a simple test without external dependencies
 */
class BasicTestRunner {

    @Test
    void testBasicKarate() {
        // Run a simple inline test that doesn't require external config
        Karate.run().scenario(
            "Feature: Basic Test\n" +
            "Scenario: Simple test\n" +
            "* def value = 'hello'\n" +
            "* match value == 'hello'\n"
        );
    }
}
