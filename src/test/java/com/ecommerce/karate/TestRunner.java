package com.ecommerce.karate;

import com.intuit.karate.junit5.Karate;
import org.junit.jupiter.api.BeforeAll;

/**
 * Test Runner for Karate API Tests
 * This class runs all the feature files in the project
 */
public class TestRunner {

    @BeforeAll
    public static void setup() {
        System.setProperty("karate.env", "dev");
        System.setProperty("karate.config.dir", "classpath:karate-config");
    }

    /**
     * Run all authentication tests
     */
    public Karate authenticationTests() {
        return Karate.run("classpath:features/authentication").relativeTo(getClass());
    }

    /**
     * Run all product catalog tests
     */
    public Karate productCatalogTests() {
        return Karate.run("classpath:features/product-catalog").relativeTo(getClass());
    }

    /**
     * Run all shopping cart tests
     */
    public Karate shoppingCartTests() {
        return Karate.run("classpath:features/shopping-cart").relativeTo(getClass());
    }

    /**
     * Run all checkout and order tests
     */
    public Karate checkoutOrderTests() {
        return Karate.run("classpath:features/checkout-orders").relativeTo(getClass());
    }

    /**
     * Run all tests in parallel
     */
    public Karate runAll() {
        return Karate.run().tags("~@ignore").parallel(4);
    }

    /**
     * Run smoke tests only
     */
    public Karate smokeTests() {
        return Karate.run().tags("@smoke").parallel(2);
    }

    /**
     * Run regression tests only
     */
    public Karate regressionTests() {
        return Karate.run().tags("@regression").parallel(4);
    }
}
