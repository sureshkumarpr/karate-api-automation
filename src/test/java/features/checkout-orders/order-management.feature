Feature: Order Management API Tests
    Test order creation, tracking, status updates, and order history

    @smoke @regression
    Scenario: Get order details by ID
        * def loginResult = call read('classpath:features/authentication/login.feature@Successful user login with valid credentials')
        * def userToken = loginResult.authToken
        # First create an order
        * def orderResult = call read('classpath:features/checkout-orders/checkout-process.feature@Complete checkout process with valid payment')
        * def orderId = orderResult.orderId
        # Get order details
        Given path endpoints.orders.get + orderId
        And header Authorization = 'Bearer ' + userToken
        When method get
        Then status 200
        And match response == { 
            orderId: orderId,
            orderNumber: '#string',
            status: '#string',
            paymentStatus: '#string',
            totalAmount: '#number',
            items: '#[1..]',
            shippingAddress: '#object',
            billingAddress: '#object',
            createdAt: '#string',
            updatedAt: '#string',
            estimatedDelivery: '#string'
        }
        * karate.log('Order details retrieved for ID:', orderId)

    @regression
    Scenario: Get order details for non-existent order
        * def loginResult = call read('classpath:features/authentication/login.feature@Successful user login with valid credentials')
        * def userToken = loginResult.authToken
        Given path endpoints.orders.get + '99999'
        And header Authorization = 'Bearer ' + userToken
        When method get
        Then status 404
        And match response == { error: { message: '#string', code: 'ORDER_NOT_FOUND' } }

    @regression
    Scenario: Get order details without authentication should fail
        Given path endpoints.orders.get + '1'
        When method get
        Then status 401
        And match response == { error: { message: '#string', code: 'UNAUTHORIZED' } }

    @smoke @regression
    Scenario: Get user order history
        * def loginResult = call read('classpath:features/authentication/login.feature@Successful user login with valid credentials')
        * def userToken = loginResult.authToken
        Given path endpoints.orders.list
        And header Authorization = 'Bearer ' + userToken
        When method get
        Then status 200
        And match response == { 
            orders: '#[0..]',
            totalCount: '#number',
            currentPage: '#number',
            totalPages: '#number'
        }
        * def orderCount = response.orders.length
        * karate.log('Found', orderCount, 'orders in user history')

    @regression
    Scenario: Order status tracking
        * def loginResult = call read('classpath:features/authentication/login.feature@Successful user login with valid credentials')
        * def userToken = loginResult.authToken
        # Create an order
        * def orderResult = call read('classpath:features/checkout-orders/checkout-process.feature@Complete checkout process with valid payment')
        * def orderId = orderResult.orderId
        # Track order status
        Given path endpoints.orders.get + orderId + '/status'
        And header Authorization = 'Bearer ' + userToken
        When method get
        Then status 200
        And match response == { 
            orderId: orderId,
            status: '#string',
            paymentStatus: '#string',
            shippingStatus: '#string',
            estimatedDelivery: '#string',
            trackingNumber: '#string?',
            lastUpdated: '#string'
        }
        * def currentStatus = response.status
        * karate.log('Current order status:', currentStatus)

    @regression
    Scenario Outline: Order status transitions
        * def loginResult = call read('classpath:features/authentication/login.feature@Successful user login with valid credentials')
        * def userToken = loginResult.authToken
        * def orderResult = call read('classpath:features/checkout-orders/checkout-process.feature@Complete checkout process with valid payment')
        * def orderId = orderResult.orderId
        # Simulate status update (admin function)
        Given path '/admin/orders/' + orderId + '/status'
        And header Authorization = 'Bearer admin_token'
        And request { status: '<newStatus>' }
        When method put
        Then status <status>
        And match response == { 
            orderId: orderId,
            status: '<newStatus>',
            message: '#string'
        }

        Examples:
            | newStatus      | status |
            | processing     | 200    |
            | shipped        | 200    |
            | delivered      | 200    |
            | cancelled      | 200    |
            | invalid_status | 400    |

    @regression
    Scenario: Cancel order
        * def loginResult = call read('classpath:features/authentication/login.feature@Successful user login with valid credentials')
        * def userToken = loginResult.authToken
        # Create an order
        * def orderResult = call read('classpath:features/checkout-orders/checkout-process.feature@Complete checkout process with valid payment')
        * def orderId = orderResult.orderId
        # Cancel the order
        Given path endpoints.orders.get + orderId + '/cancel'
        And header Authorization = 'Bearer ' + userToken
        And request { reason: 'Customer request' }
        When method post
        Then status 200
        And match response == { 
            orderId: orderId,
            status: 'cancelled',
            refundStatus: '#string',
            message: 'Order cancelled successfully'
        }
        * karate.log('Order cancelled successfully')

    @regression
    Scenario: Cancel shipped order should fail
        * def loginResult = call read('classpath:features/authentication/login.feature@Successful user login with valid credentials')
        * def userToken = loginResult.authToken
        * def orderResult = call read('classpath:features/checkout-orders/checkout-process.feature@Complete checkout process with valid payment')
        * def orderId = orderResult.orderId
        # Update order to shipped status (admin)
        Given path '/admin/orders/' + orderId + '/status'
        And header Authorization = 'Bearer admin_token'
        And request { status: 'shipped' }
        When method put
        Then status 200
        # Try to cancel shipped order
        Given path endpoints.orders.get + orderId + '/cancel'
        And header Authorization = 'Bearer ' + userToken
        And request { reason: 'Customer request' }
        When method post
        Then status 400
        And match response == { error: { message: '#string', code: 'CANNOT_CANCEL_SHIPPED' } }

    @regression
    Scenario: Order refund processing
        * def loginResult = call read('classpath:features/authentication/login.feature@Successful user login with valid credentials')
        * def userToken = loginResult.authToken
        * def orderResult = call read('classpath:features/checkout-orders/checkout-process.feature@Complete checkout process with valid payment')
        * def orderId = orderResult.orderId
        # Cancel order to trigger refund
        Given path endpoints.orders.get + orderId + '/cancel'
        And header Authorization = 'Bearer ' + userToken
        And request { reason: 'Customer request' }
        When method post
        Then status 200
        # Check refund status
        Given path endpoints.orders.get + orderId + '/refund'
        And header Authorization = 'Bearer ' + userToken
        When method get
        Then status 200
        And match response == { 
            orderId: orderId,
            refundStatus: '#string',
            refundAmount: '#number',
            refundMethod: '#string',
            processedAt: '#string'
        }
        * karate.log('Refund processed successfully')

    @regression
    Scenario: Order re-order functionality
        * def loginResult = call read('classpath:features/authentication/login.feature@Successful user login with valid credentials')
        * def userToken = loginResult.authToken
        * def orderResult = call read('classpath:features/checkout-orders/checkout-process.feature@Complete checkout process with valid payment')
        * def orderId = orderResult.orderId
        # Re-order items
        Given path endpoints.orders.get + orderId + '/reorder'
        And header Authorization = 'Bearer ' + userToken
        When method post
        Then status 200
        And match response == { 
            message: 'Items added to cart successfully',
            itemsAdded: '#number',
            cartTotal: '#number'
        }
        # Verify items in cart
        Given path endpoints.cart.get
        And header Authorization = 'Bearer ' + userToken
        When method get
        Then status 200
        And match response.itemCount > 0
        * karate.log('Re-order functionality working')

    @regression
    Scenario: Order search and filtering
        * def loginResult = call read('classpath:features/authentication/login.feature@Successful user login with valid credentials')
        * def userToken = loginResult.authToken
        Given path endpoints.orders.list
        And header Authorization = 'Bearer ' + userToken
        And param status = 'delivered'
        And param startDate = '2024-01-01'
        And param endDate = '2024-12-31'
        When method get
        Then status 200
        And match response == { 
            orders: '#[0..]',
            totalCount: '#number',
            filters: {
                status: 'delivered',
                startDate: '2024-01-01',
                endDate: '2024-12-31'
            }
        }
        * def filteredOrders = response.orders.length
        * karate.log('Found', filteredOrders, 'delivered orders')

    @regression
    Scenario: Order export functionality
        * def loginResult = call read('classpath:features/authentication/login.feature@Successful user login with valid credentials')
        * def userToken = loginResult.authToken
        Given path endpoints.orders.list + '/export'
        And header Authorization = 'Bearer ' + userToken
        And param format = 'csv'
        And param startDate = '2024-01-01'
        And param endDate = '2024-12-31'
        When method get
        Then status 200
        And match responseHeaders['Content-Type'] == 'text/csv'
        * karate.log('Order export completed successfully')

    @performance
    Scenario: Performance test for order retrieval
        * def loginResult = call read('classpath:features/authentication/login.feature@Successful user login with valid credentials')
        * def userToken = loginResult.authToken
        * def orderIds = []
        # Create multiple orders
        * for (i = 0; i < 5; i++)
            * def orderResult = call read('classpath:features/checkout-orders/checkout-process.feature@Complete checkout process with valid payment')
            * orderIds.push(orderResult.orderId)
        * def retrievalTimes = []
        * for (i = 0; i < orderIds.length; i++)
            * def startTime = new Date().getTime()
            Given path endpoints.orders.get + orderIds[i]
            And header Authorization = 'Bearer ' + userToken
            When method get
            Then status 200
            * def endTime = new Date().getTime()
            * def retrievalTime = endTime - startTime
            * retrievalTimes.push(retrievalTime)
        * def avgRetrievalTime = retrievalTimes.reduce((sum, time) => sum + time, 0) / retrievalTimes.length
        * karate.log('Average order retrieval time:', avgRetrievalTime, 'ms')
        * match avgRetrievalTime < 500
