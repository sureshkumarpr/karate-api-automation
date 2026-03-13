Feature: Shopping Cart API Tests
    Test shopping cart CRUD operations, inventory checks, and cart management

    @smoke @regression
    Scenario: Get user cart (empty cart)
        * def loginResult = call read('classpath:features/authentication/login.feature@Successful user login with valid credentials')
        * def userToken = loginResult.authToken
        Given path endpoints.cart.get
        And header Authorization = 'Bearer ' + userToken
        When method get
        Then status 200
        And match response == { 
            userId: '#number', 
            items: '#[]', 
            totalAmount: 0,
            itemCount: 0,
            lastUpdated: '#string'
        }
        * karate.log('Empty cart retrieved successfully')

    @smoke @regression
    Scenario: Add item to cart
        * def loginResult = call read('classpath:features/authentication/login.feature@Successful user login with valid credentials')
        * def userToken = loginResult.authToken
        Given path endpoints.cart.add
        And header Authorization = 'Bearer ' + userToken
        And request
        """
        {
            productId: 1,
            quantity: 2,
            price: 99.99
        }
        """
        When method post
        Then status 201
        And match response == { 
            cartId: '#number',
            userId: '#number',
            items: '#[1]',
            totalAmount: 199.98,
            itemCount: 2,
            message: 'Item added to cart successfully'
        }
        And match response.items[0] == { 
            productId: 1, 
            quantity: 2, 
            price: 99.99,
            totalPrice: 199.98,
            addedAt: '#string'
        }
        * def cartItemId = response.items[0].id
        * karate.log('Item added to cart with ID:', cartItemId)

    @regression
    Scenario: Add item to cart without authentication should fail
        Given path endpoints.cart.add
        And request { productId: 1, quantity: 1, price: 99.99 }
        When method post
        Then status 401
        And match response == { error: { message: '#string', code: 'UNAUTHORIZED' } }

    @regression
    Scenario Outline: Add item to cart validation
        * def loginResult = call read('classpath:features/authentication/login.feature@Successful user login with valid credentials')
        * def userToken = loginResult.authToken
        Given path endpoints.cart.add
        And header Authorization = 'Bearer ' + userToken
        And request
        """
        {
            productId: <productId>,
            quantity: <quantity>,
            price: <price>
        }
        """
        When method post
        Then status <status>
        And match response == { error: { message: '#string', field: '<field>', code: '<errorCode>' } }

        Examples:
            | productId | quantity | price | status | field     | errorCode           |
            |           | 2        | 99.99 | 400    | productId | MISSING_PRODUCT_ID  |
            | 1         |          | 99.99 | 400    | quantity  | MISSING_QUANTITY    |
            | 1         | 2        |       | 400    | price    | MISSING_PRICE       |
            | 99999     | 2        | 99.99 | 404    | productId | PRODUCT_NOT_FOUND   |
            | 1         | 0        | 99.99 | 400    | quantity  | INVALID_QUANTITY    |
            | 1         | -1       | 99.99 | 400    | quantity  | INVALID_QUANTITY    |
            | 1         | 2        | -10   | 400    | price    | INVALID_PRICE       |

    @regression
    Scenario: Add item with insufficient inventory should fail
        * def loginResult = call read('classpath:features/authentication/login.feature@Successful user login with valid credentials')
        * def userToken = loginResult.authToken
        Given path endpoints.cart.add
        And header Authorization = 'Bearer ' + userToken
        And request { productId: 1, quantity: 1000, price: 99.99 }
        When method post
        Then status 409
        And match response == { error: { message: '#string', code: 'INSUFFICIENT_INVENTORY' } }

    @regression
    Scenario: Update cart item quantity
        * def loginResult = call read('classpath:features/authentication/login.feature@Successful user login with valid credentials')
        * def userToken = loginResult.authToken
        # First add an item
        Given path endpoints.cart.add
        And header Authorization = 'Bearer ' + userToken
        And request { productId: 2, quantity: 1, price: 149.99 }
        When method post
        Then status 201
        * def cartItemId = response.items[0].id
        # Update the quantity
        Given path endpoints.cart.update + '/items/' + cartItemId
        And header Authorization = 'Bearer ' + userToken
        And request { quantity: 3 }
        When method put
        Then status 200
        And match response == { 
            cartId: '#number',
            items: '#[1]',
            totalAmount: 449.97,
            itemCount: 3,
            message: 'Cart item updated successfully'
        }
        And match response.items[0].quantity == 3
        * karate.log('Cart item quantity updated to 3')

    @regression
    Scenario: Remove item from cart
        * def loginResult = call read('classpath:features/authentication/login.feature@Successful user login with valid credentials')
        * def userToken = loginResult.authToken
        # First add an item
        Given path endpoints.cart.add
        And header Authorization = 'Bearer ' + userToken
        And request { productId: 3, quantity: 1, price: 79.99 }
        When method post
        Then status 201
        * def cartItemId = response.items[0].id
        # Remove the item
        Given path endpoints.cart.delete + '/items/' + cartItemId
        And header Authorization = 'Bearer ' + userToken
        When method delete
        Then status 200
        And match response == { 
            message: 'Item removed from cart successfully',
            cartId: '#number',
            remainingItems: '#number'
        }
        * karate.log('Item removed from cart')

    @smoke
    Scenario: View cart with multiple items
        * def loginResult = call read('classpath:features/authentication/login.feature@Successful user login with valid credentials')
        * def userToken = loginResult.authToken
        # Add multiple items
        * def itemsToAdd = [
            { productId: 1, quantity: 2, price: 99.99 },
            { productId: 2, quantity: 1, price: 149.99 },
            { productId: 3, quantity: 3, price: 79.99 }
        ]
        * for (i = 0; i < itemsToAdd.length; i++)
            Given path endpoints.cart.add
            And header Authorization = 'Bearer ' + userToken
            And request itemsToAdd[i]
            When method post
            Then status 201
        # View the cart
        Given path endpoints.cart.get
        And header Authorization = 'Bearer ' + userToken
        When method get
        Then status 200
        And match response == { 
            userId: '#number', 
            items: '#[3]', 
            totalAmount: '#number',
            itemCount: 6,
            lastUpdated: '#string'
        }
        * def cartTotal = response.totalAmount
        * karate.log('Cart total with multiple items:', cartTotal)

    @regression
    Scenario: Clear entire cart
        * def loginResult = call read('classpath:features/authentication/login.feature@Successful user login with valid credentials')
        * def userToken = loginResult.authToken
        # Add items first
        Given path endpoints.cart.add
        And header Authorization = 'Bearer ' + userToken
        And request { productId: 1, quantity: 2, price: 99.99 }
        When method post
        Then status 201
        # Clear the cart
        Given path endpoints.cart.delete
        And header Authorization = 'Bearer ' + userToken
        When method delete
        Then status 200
        And match response == { 
            message: 'Cart cleared successfully',
            cartId: '#number',
            itemsRemoved: '#number'
        }
        # Verify cart is empty
        Given path endpoints.cart.get
        And header Authorization = 'Bearer ' + userToken
        When method get
        Then status 200
        And match response.items == '#[]'
        * karate.log('Cart cleared successfully')

    @regression
    Scenario: Calculate cart totals with discounts
        * def loginResult = call read('classpath:features/authentication/login.feature@Successful user login with valid credentials')
        * def userToken = loginResult.authToken
        # Add items
        Given path endpoints.cart.add
        And header Authorization = 'Bearer ' + userToken
        And request { productId: 1, quantity: 2, price: 99.99 }
        When method post
        Then status 201
        # Apply discount code
        Given path endpoints.cart.update + '/discount'
        And header Authorization = 'Bearer ' + userToken
        And request { discountCode: 'SAVE10' }
        When method put
        Then status 200
        And match response == { 
            cartId: '#number',
            subtotal: 199.98,
            discountAmount: 19.998,
            totalAmount: 179.982,
            discountCode: 'SAVE10',
            discountPercentage: 10
        }
        * karate.log('Discount applied successfully')

    @regression
    Scenario: Apply invalid discount code
        * def loginResult = call read('classpath:features/authentication/login.feature@Successful user login with valid credentials')
        * def userToken = loginResult.authToken
        Given path endpoints.cart.update + '/discount'
        And header Authorization = 'Bearer ' + userToken
        And request { discountCode: 'INVALID' }
        When method put
        Then status 400
        And match response == { error: { message: '#string', code: 'INVALID_DISCOUNT_CODE' } }

    @performance
    Scenario: Performance test for cart operations
        * def loginResult = call read('classpath:features/authentication/login.feature@Successful user login with valid credentials')
        * def userToken = loginResult.authToken
        * def operationTimes = []
        * for (i = 0; i < 10; i++)
            * def startTime = new Date().getTime()
            Given path endpoints.cart.add
            And header Authorization = 'Bearer ' + userToken
            And request { productId: (i % 5) + 1, quantity: 1, price: 99.99 }
            When method post
            Then status 201
            * def endTime = new Date().getTime()
            * def operationTime = endTime - startTime
            * operationTimes.push(operationTime)
        * def avgOperationTime = operationTimes.reduce((sum, time) => sum + time, 0) / operationTimes.length
        * karate.log('Average cart operation time:', avgOperationTime, 'ms')
        * match avgOperationTime < 1000
