Feature: Shopping Cart Validation Tests
    Test cart validation rules, business logic, and edge cases

    @regression
    Scenario: Add duplicate items to cart (should update quantity)
        * def loginResult = call read('classpath:features/authentication/login.feature@Successful user login with valid credentials')
        * def userToken = loginResult.authToken
        # Add item first time
        Given path endpoints.cart.add
        And header Authorization = 'Bearer ' + userToken
        And request { productId: 1, quantity: 2, price: 99.99 }
        When method post
        Then status 201
        * def firstAddResponse = response
        # Add same item again
        Given path endpoints.cart.add
        And header Authorization = 'Bearer ' + userToken
        And request { productId: 1, quantity: 3, price: 99.99 }
        When method post
        Then status 200
        And match response == { 
            message: 'Item quantity updated in cart',
            cartId: '#number',
            items: '#[1]',
            totalAmount: 499.95,
            itemCount: 5
        }
        And match response.items[0].quantity == 5
        * karate.log('Duplicate item added, quantity updated to 5')

    @regression
    Scenario: Add items exceeding maximum quantity limit
        * def loginResult = call read('classpath:features/authentication/login.feature@Successful user login with valid credentials')
        * def userToken = loginResult.authToken
        Given path endpoints.cart.add
        And header Authorization = 'Bearer ' + userToken
        And request { productId: 1, quantity: 101, price: 99.99 }
        When method post
        Then status 400
        And match response == { error: { message: '#string', code: 'MAX_QUANTITY_EXCEEDED' } }

    @regression
    Scenario: Update cart item to zero quantity (should remove item)
        * def loginResult = call read('classpath:features/authentication/login.feature@Successful user login with valid credentials')
        * def userToken = loginResult.authToken
        # Add an item first
        Given path endpoints.cart.add
        And header Authorization = 'Bearer ' + userToken
        And request { productId: 1, quantity: 2, price: 99.99 }
        When method post
        Then status 201
        * def cartItemId = response.items[0].id
        # Update quantity to 0
        Given path endpoints.cart.update + '/items/' + cartItemId
        And header Authorization = 'Bearer ' + userToken
        And request { quantity: 0 }
        When method put
        Then status 200
        And match response == { 
            message: 'Item removed from cart (quantity set to 0)',
            cartId: '#number',
            items: '#[]'
        }
        * karate.log('Item removed by setting quantity to 0')

    @regression
    Scenario: Price mismatch validation
        * def loginResult = call read('classpath:features/authentication/login.feature@Successful user login with valid credentials')
        * def userToken = loginResult.authToken
        # Try to add item with wrong price
        Given path endpoints.cart.add
        And header Authorization = 'Bearer ' + userToken
        And request { productId: 1, quantity: 1, price: 1.99 }
        When method post
        Then status 400
        And match response == { error: { message: '#string', code: 'PRICE_MISMATCH' } }

    @regression
    Scenario: Cart session timeout test
        * def loginResult = call read('classpath:features/authentication/login.feature@Successful user login with valid credentials')
        * def userToken = loginResult.authToken
        # Add item to cart
        Given path endpoints.cart.add
        And header Authorization = 'Bearer ' + userToken
        And request { productId: 1, quantity: 2, price: 99.99 }
        When method post
        Then status 201
        # Simulate session expiry by using expired token
        Given path endpoints.cart.get
        And header Authorization = 'Bearer expired_token_123'
        When method get
        Then status 401
        And match response == { error: { message: '#string', code: 'TOKEN_EXPIRED' } }

    @regression
    Scenario: Concurrent cart operations
        * def loginResult = call read('classpath:features/authentication/login.feature@Successful user login with valid credentials')
        * def userToken = loginResult.authToken
        * def results = []
        # Simulate concurrent additions
        * for (i = 0; i < 5; i++)
            * def result = call 
            """
            function(token, productId, quantity, price) {
                var config = karate.read('classpath:karate-config.js');
                var headers = { 'Content-Type': 'application/json', 'Authorization': 'Bearer ' + token };
                var payload = { productId: productId, quantity: quantity, price: price };
                var response = karate.post(config.baseUrl + '/carts', payload, headers);
                return {
                    status: response.status,
                    response: response.response
                };
            }
            """
            , userToken, (i % 3) + 1, 1, 99.99
            * results.push(result)
        * def successCount = results.filter(r => r.status === 201 || r.status === 200).length
        * karate.log('Concurrent operations completed. Success count:', successCount)

    @regression
    Scenario: Cart persistence across sessions
        * def loginResult = call read('classpath:features/authentication/login.feature@Successful user login with valid credentials')
        * def userToken = loginResult.authToken
        # Add item in first session
        Given path endpoints.cart.add
        And header Authorization = 'Bearer ' + userToken
        And request { productId: 1, quantity: 2, price: 99.99 }
        When method post
        Then status 201
        * def firstSessionCart = response
        # Get cart in new session (simulate new login)
        Given path endpoints.cart.get
        And header Authorization = 'Bearer ' + userToken
        When method get
        Then status 200
        And match response.itemCount == firstSessionCart.itemCount
        And match response.totalAmount == firstSessionCart.totalAmount
        * karate.log('Cart persisted across sessions')

    @regression
    Scenario: Cart with expired products
        * def loginResult = call read('classpath:features/authentication/login.feature@Successful user login with valid credentials')
        * def userToken = loginResult.authToken
        # Try to add an expired product
        Given path endpoints.cart.add
        And header Authorization = 'Bearer ' + userToken
        And request { productId: 999, quantity: 1, price: 99.99 }
        When method post
        Then status 400
        And match response == { error: { message: '#string', code: 'PRODUCT_EXPIRED' } }

    @regression
    Scenario: Cart size limit validation
        * def loginResult = call read('classpath:features/authentication/login.feature@Successful user login with valid credentials')
        * def userToken = loginResult.authToken
        * def cartItems = []
        # Try to add more items than cart limit
        * for (i = 0; i < 51; i++)
            * def result = call 
            """
            function(token, productId, quantity, price) {
                var config = karate.read('classpath:karate-config.js');
                var headers = { 'Content-Type': 'application/json', 'Authorization': 'Bearer ' + token };
                var payload = { productId: productId, quantity: quantity, price: price };
                var response = karate.post(config.baseUrl + '/carts', payload, headers);
                return { status: response.status };
            }
            """
            , userToken, (i % 10) + 1, 1, 99.99
            * cartItems.push(result)
            * if (result.status === 400)
                * break
        * def lastStatus = cartItems[cartItems.length - 1].status
        * match lastStatus == 400
        * karate.log('Cart size limit enforced')

    @regression
    Scenario: Cart total calculation accuracy
        * def loginResult = call read('classpath:features/authentication/login.feature@Successful user login with valid credentials')
        * def userToken = loginResult.authToken
        * def testItems = [
            { productId: 1, quantity: 2, price: 99.99 },
            { productId: 2, quantity: 1, price: 149.99 },
            { productId: 3, quantity: 3, price: 79.99 }
        ]
        * def expectedTotal = 0
        * for (i = 0; i < testItems.length; i++)
            * def item = testItems[i]
            * expectedTotal += item.quantity * item.price
            Given path endpoints.cart.add
            And header Authorization = 'Bearer ' + userToken
            And request item
            When method post
            Then status 201
        # Verify total calculation
        Given path endpoints.cart.get
        And header Authorization = 'Bearer ' + userToken
        When method get
        Then status 200
        And match response.totalAmount == expectedTotal
        * karate.log('Cart total calculation verified:', expectedTotal)

    @regression
    Scenario: Cart merge for guest users
        # Simulate guest cart
        Given path '/guest/cart'
        And request { items: [{ productId: 1, quantity: 1, price: 99.99 }] }
        When method post
        Then status 200
        * def guestCartId = response.cartId
        # Login and merge cart
        * def loginResult = call read('classpath:features/authentication/login.feature@Successful user login with valid credentials')
        * def userToken = loginResult.authToken
        Given path '/cart/merge'
        And header Authorization = 'Bearer ' + userToken
        And request { guestCartId: guestCartId }
        When method post
        Then status 200
        And match response == { 
            message: 'Cart merged successfully',
            mergedItems: '#number',
            totalAmount: '#number'
        }
        * karate.log('Guest cart merged successfully')
