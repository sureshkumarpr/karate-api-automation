Feature: Checkout Process API Tests
    Test payment processing, order creation, and checkout workflows

    @smoke @regression
    Scenario: Complete checkout process with valid payment
        * def loginResult = call read('classpath:features/authentication/login.feature@Successful user login with valid credentials')
        * def userToken = loginResult.authToken
        # Add items to cart first
        Given path endpoints.cart.add
        And header Authorization = 'Bearer ' + userToken
        And request { productId: 1, quantity: 2, price: 99.99 }
        When method post
        Then status 201
        # Process checkout
        Given path endpoints.checkout
        And header Authorization = 'Bearer ' + userToken
        And request
        """
        {
            paymentMethod: 'credit_card',
            paymentDetails: {
                cardNumber: '4111111111111111',
                expiryMonth: 12,
                expiryYear: 2025,
                cvv: '123',
                holderName: 'John Doe'
            },
            shippingAddress: {
                street: '123 Test St',
                city: 'Test City',
                state: 'TS',
                zipCode: '12345',
                country: 'USA'
            },
            billingAddress: {
                street: '123 Test St',
                city: 'Test City',
                state: 'TS',
                zipCode: '12345',
                country: 'USA'
            }
        }
        """
        When method post
        Then status 201
        And match response == { 
            orderId: '#number',
            orderNumber: '#string',
            status: 'confirmed',
            paymentStatus: 'paid',
            totalAmount: 199.98,
            items: '#[1]',
            shippingAddress: '#object',
            billingAddress: '#object',
            estimatedDelivery: '#string',
            createdAt: '#string'
        }
        * def orderId = response.orderId
        * def orderNumber = response.orderNumber
        * karate.log('Order created successfully with ID:', orderId, 'Number:', orderNumber)

    @regression
    Scenario: Checkout with empty cart should fail
        * def loginResult = call read('classpath:features/authentication/login.feature@Successful user login with valid credentials')
        * def userToken = loginResult.authToken
        # Ensure cart is empty
        Given path endpoints.cart.delete
        And header Authorization = 'Bearer ' + userToken
        When method delete
        Then status 200
        # Try checkout
        Given path endpoints.checkout
        And header Authorization = 'Bearer ' + userToken
        And request
        """
        {
            paymentMethod: 'credit_card',
            paymentDetails: {
                cardNumber: '4111111111111111',
                expiryMonth: 12,
                expiryYear: 2025,
                cvv: '123'
            },
            shippingAddress: {
                street: '123 Test St',
                city: 'Test City',
                state: 'TS',
                zipCode: '12345'
            }
        }
        """
        When method post
        Then status 400
        And match response == { error: { message: '#string', code: 'EMPTY_CART' } }

    @regression
    Scenario: Checkout without authentication should fail
        Given path endpoints.checkout
        And request { paymentMethod: 'credit_card' }
        When method post
        Then status 401
        And match response == { error: { message: '#string', code: 'UNAUTHORIZED' } }

    @regression
    Scenario Outline: Payment method validation
        * def loginResult = call read('classpath:features/authentication/login.feature@Successful user login with valid credentials')
        * def userToken = loginResult.authToken
        # Add item to cart
        Given path endpoints.cart.add
        And header Authorization = 'Bearer ' + userToken
        And request { productId: 1, quantity: 1, price: 99.99 }
        When method post
        Then status 201
        # Try checkout with different payment methods
        Given path endpoints.checkout
        And header Authorization = 'Bearer ' + userToken
        And request
        """
        {
            paymentMethod: '<paymentMethod>',
            paymentDetails: <paymentDetails>,
            shippingAddress: {
                street: '123 Test St',
                city: 'Test City',
                state: 'TS',
                zipCode: '12345',
                country: 'USA'
            }
        }
        """
        When method post
        Then status <status>
        And match response == { error: { message: '#string', code: '<errorCode>' } }

        Examples:
            | paymentMethod | paymentDetails | status | errorCode              |
            |               | {}             | 400    | MISSING_PAYMENT_METHOD |
            | invalid       | {}             | 400    | INVALID_PAYMENT_METHOD |
            | credit_card   |                | 400    | MISSING_PAYMENT_DETAILS |
            | paypal        | {}             | 400    | MISSING_PAYPAL_EMAIL   |

    @regression
    Scenario: Credit card validation
        * def loginResult = call read('classpath:features/authentication/login.feature@Successful user login with valid credentials')
        * def userToken = loginResult.authToken
        # Add item to cart
        Given path endpoints.cart.add
        And header Authorization = 'Bearer ' + userToken
        And request { productId: 1, quantity: 1, price: 99.99 }
        When method post
        Then status 201
        # Try with invalid card details
        Given path endpoints.checkout
        And header Authorization = 'Bearer ' + userToken
        And request
        """
        {
            paymentMethod: 'credit_card',
            paymentDetails: {
                cardNumber: '1234567890123456',
                expiryMonth: 13,
                expiryYear: 2020,
                cvv: '12',
                holderName: ''
            },
            shippingAddress: {
                street: '123 Test St',
                city: 'Test City',
                state: 'TS',
                zipCode: '12345',
                country: 'USA'
            }
        }
        """
        When method post
        Then status 400
        And match response == { error: { message: '#string', code: 'INVALID_CARD_DETAILS' } }

    @regression
    Scenario: Address validation
        * def loginResult = call read('classpath:features/authentication/login.feature@Successful user login with valid credentials')
        * def userToken = loginResult.authToken
        # Add item to cart
        Given path endpoints.cart.add
        And header Authorization = 'Bearer ' + userToken
        And request { productId: 1, quantity: 1, price: 99.99 }
        When method post
        Then status 201
        # Try with invalid address
        Given path endpoints.checkout
        And header Authorization = 'Bearer ' + userToken
        And request
        """
        {
            paymentMethod: 'credit_card',
            paymentDetails: {
                cardNumber: '4111111111111111',
                expiryMonth: 12,
                expiryYear: 2025,
                cvv: '123'
            },
            shippingAddress: {
                street: '',
                city: '',
                state: '',
                zipCode: '',
                country: ''
            }
        }
        """
        When method post
        Then status 400
        And match response == { error: { message: '#string', code: 'INVALID_ADDRESS' } }

    @regression
    Scenario: Payment failure simulation
        * def loginResult = call read('classpath:features/authentication/login.feature@Successful user login with valid credentials')
        * def userToken = loginResult.authToken
        # Add item to cart
        Given path endpoints.cart.add
        And header Authorization = 'Bearer ' + userToken
        And request { productId: 1, quantity: 1, price: 99.99 }
        When method post
        Then status 201
        # Simulate payment failure
        Given path endpoints.checkout
        And header Authorization = 'Bearer ' + userToken
        And request
        """
        {
            paymentMethod: 'credit_card',
            paymentDetails: {
                cardNumber: '4000000000000002', // Known test failure card
                expiryMonth: 12,
                expiryYear: 2025,
                cvv: '123'
            },
            shippingAddress: {
                street: '123 Test St',
                city: 'Test City',
                state: 'TS',
                zipCode: '12345',
                country: 'USA'
            }
        }
        """
        When method post
        Then status 402
        And match response == { error: { message: '#string', code: 'PAYMENT_FAILED' } }

    @smoke
    Scenario: Checkout with different payment methods
        * def loginResult = call read('classpath:features/authentication/login.feature@Successful user login with valid credentials')
        * def userToken = loginResult.authToken
        * def paymentMethods = ['credit_card', 'paypal', 'apple_pay', 'google_pay']
        * for (i = 0; i < paymentMethods.length; i++)
            # Clear cart and add item
            Given path endpoints.cart.delete
            And header Authorization = 'Bearer ' + userToken
            When method delete
            Then status 200
            Given path endpoints.cart.add
            And header Authorization = 'Bearer ' + userToken
            And request { productId: 1, quantity: 1, price: 99.99 }
            When method post
            Then status 201
            # Try different payment method
            Given path endpoints.checkout
            And header Authorization = 'Bearer ' + userToken
            And request
            """
            {
                paymentMethod: '""" + paymentMethods[i] + """',
                paymentDetails: getPaymentDetails('""" + paymentMethods[i] + """'),
                shippingAddress: {
                    street: '123 Test St',
                    city: 'Test City',
                    state: 'TS',
                    zipCode: '12345',
                    country: 'USA'
                }
            }
            """
            When method post
            Then status 201
            * karate.log('Checkout successful with', paymentMethods[i])

    @regression
    Scenario: Apply discount during checkout
        * def loginResult = call read('classpath:features/authentication/login.feature@Successful user login with valid credentials')
        * def userToken = loginResult.authToken
        # Add item to cart
        Given path endpoints.cart.add
        And header Authorization = 'Bearer ' + userToken
        And request { productId: 1, quantity: 2, price: 99.99 }
        When method post
        Then status 201
        # Apply discount
        Given path endpoints.cart.update + '/discount'
        And header Authorization = 'Bearer ' + userToken
        And request { discountCode: 'SAVE20' }
        When method put
        Then status 200
        # Checkout with discount
        Given path endpoints.checkout
        And header Authorization = 'Bearer ' + userToken
        And request
        """
        {
            paymentMethod: 'credit_card',
            paymentDetails: {
                cardNumber: '4111111111111111',
                expiryMonth: 12,
                expiryYear: 2025,
                cvv: '123'
            },
            shippingAddress: {
                street: '123 Test St',
                city: 'Test City',
                state: 'TS',
                zipCode: '12345',
                country: 'USA'
            },
            applyDiscount: true
        }
        """
        When method post
        Then status 201
        And match response == { 
            orderId: '#number',
            totalAmount: 159.982,
            discountAmount: 39.998,
            finalAmount: 159.982
        }
        * karate.log('Checkout with discount applied successfully')

    @regression
    Scenario: Guest checkout
        Given path endpoints.cart.add
        And request { productId: 1, quantity: 1, price: 99.99, guestId: 'guest_' + new Date().getTime() }
        When method post
        Then status 201
        # Guest checkout
        Given path '/guest/checkout'
        And request
        """
        {
            email: 'guest@test.com',
            paymentMethod: 'credit_card',
            paymentDetails: {
                cardNumber: '4111111111111111',
                expiryMonth: 12,
                expiryYear: 2025,
                cvv: '123'
            },
            shippingAddress: {
                street: '123 Test St',
                city: 'Test City',
                state: 'TS',
                zipCode: '12345',
                country: 'USA'
            }
        }
        """
        When method post
        Then status 201
        And match response == { 
            orderId: '#number',
            guestCheckout: true,
            status: 'confirmed'
        }
        * karate.log('Guest checkout completed successfully')
