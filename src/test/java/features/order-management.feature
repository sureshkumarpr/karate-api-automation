Feature: Order Management API Testing
  As an e-commerce customer
  I want to place and track orders
  So that I can complete purchases

Background:
  * url 'https://api.ossjavahub.com'
  * header Content-Type = 'application/json'
  * header Accept = 'application/json'

Scenario: Create new order - Should Pass
  Given path '/orders'
  And request { userId: 123, items: [{ productId: 101, quantity: 2, price: 29.99 }], shippingAddress: { street: '123 Test St', city: 'Chennai', state: 'Tamilnadu', zip: '600001' } }
  When method POST
  Then status 201
  And match response.userId == 123
  And match response.orderId == '#number'
  And match response.status == 'pending'
  And match response.totalAmount > 0

Scenario: Get order by ID - Should Pass
  Given path '/orders/1001'
  When method GET
  Then status 200
  And match response.orderId == 1001
  And match response.userId == '#number'
  And match response.status == '#string'
  And match response.items[*].productId == '#number'

Scenario: Get orders by user ID - Should Pass
  Given path '/orders/user/123'
  When method GET
  Then status 200
  And match response[*].userId == 123
  And match response[*].orderId == '#number'

Scenario: Update order status - Should Pass
  Given path '/orders/1001/status'
  And request { status: 'shipped', trackingNumber: 'TRK123456789' }
  When method PUT
  Then status 200
  And match response.status == 'shipped'
  And match response.trackingNumber == 'TRK123456789'

Scenario: Cancel order - Should Pass
  Given path '/orders/1001/cancel'
  When method POST
  Then status 200
  And match response.success == true
  And match response.message == 'Order cancelled successfully'

Scenario: Get order tracking - Should Pass
  Given path '/orders/1001/tracking'
  When method GET
  Then status 200
  And match response.trackingNumber == '#string'
  And match response.status == '#string'
  And match response.estimatedDelivery == '#string'

Scenario: Create order with invalid data - Should Fail
  Given path '/orders'
  And request { userId: 'invalid', items: [], shippingAddress: {} }
  When method POST
  Then status 400
  And match response.error contains 'Invalid order data'

Scenario: Get non-existent order - Should Fail
  Given path '/orders/99999'
  When method GET
  Then status 404
  And match response.error == 'Order not found'

Scenario Outline: Data-driven order creation - Should Pass
  Given path '/orders'
  And request { userId: <userId>, items: [{ productId: <productId>, quantity: <quantity>, price: <price> }], shippingAddress: { street: '<street>', city: '<city>', state: '<state>', zip: '<zip>' } }
  When method POST
  Then status 201
  And match response.userId == <userId>
  And match response.totalAmount == <quantity> * <price>

  Examples:
    | userId | productId | quantity | price  | street        | city    | state    | zip    |
    | 123    | 101       | 2        | 29.99  | '123 Test St' | 'Chennai' | 'Tamilnadu' | '600001' |
    | 456    | 102       | 1        | 49.99  | '456 Main Ave' | 'Mumbai' | 'Maharashtra' | '400001' |
    | 789    | 103       | 3        | 19.99  | '789 Park Rd' | 'Delhi'  | 'Delhi'    | '110001' |

Scenario: Validate order totals - Should Pass
  Given path '/orders/1001'
  When method GET
  Then status 200
  And match response.totalAmount == response.items[*].price * response.items[*].quantity
  And match response.items[*].quantity > 0
