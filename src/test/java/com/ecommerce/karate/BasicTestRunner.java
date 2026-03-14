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
        // Run the basic test feature file
        Karate.run("classpath:features/basic/basic-test.feature").tags("~@ignore");
    }
}
