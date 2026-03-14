package com.ecommerce.karate;

import com.intuit.karate.junit5.Karate;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;

/**
 * Test Runner for Karate API Tests
 * This class runs all the feature files in the project
 */
class TestRunner {

    @BeforeAll
    public static void setup() {
        System.setProperty("karate.env", "dev");
        System.setProperty("karate.config.dir", "classpath:karate-config");
    }

    @Test
    void testAllFeatures() {
        Karate.run("classpath:features").tags("~@ignore").parallel(4);
    }
}
