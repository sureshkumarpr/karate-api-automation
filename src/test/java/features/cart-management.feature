Feature: Cart Management API Testing
  As an e-commerce customer
  I want to manage my shopping cart
  So that I can add, view, and update cart items

Background:
  * url 'https://api.ossjavahub.com'
  * header Content-Type = 'application/json'
  * header Accept = 'application/json'

Scenario: Get all carts - Should Pass
  Given path '/carts'
  When method GET
  Then status 200
  And match response[*] contains { id: '#number', userId: '#number', total: '#number', totalQuantity: '#number' }
  And match response[0].totalQuantity >= 0

Scenario: Get cart by ID - Should Pass
  Given path '/carts/1'
  When method GET
  Then status 200
  And match response.id == 1
  And match response.userId == '#number'
  And match response.total == '#number'
  And match response.items[*].productId == '#number'

Scenario: Get cart by user ID - Should Pass
  Given path '/carts/user/123'
  When method GET
  Then status 200
  And match response.userId == 123
  And match response.items[*].quantity > 0

Scenario: Create new cart - Should Pass
  Given path '/carts'
  And request { userId: 456, items: [{ productId: 101, quantity: 2, price: 29.99 }, { productId: 102, quantity: 1, price: 49.99 }] }
  When method POST
  Then status 201
  And match response.userId == 456
  And match response.total == '#number'
  And match response.totalQuantity == 3

Scenario: Add item to cart - Should Pass
  Given path '/carts/add'
  And request { cartId: 1, productId: 103, quantity: 1 }
  When method POST
  Then status 200
  And match response.success == true
  And match response.message == 'Item added to cart'

Scenario: Update cart item - Should Pass
  Given path '/carts/1/items/101'
  And request { quantity: 5 }
  When method PUT
  Then status 200
  And match response.quantity == 5

Scenario: Remove item from cart - Should Pass
  Given path '/carts/1/items/101'
  When method DELETE
  Then status 200
  And match response.success == true

Scenario: Clear cart - Should Pass
  Given path '/carts/1/clear'
  When method DELETE
  Then status 200
  And match response.success == true
  And match response.message == 'Cart cleared successfully'

Scenario: Get cart with invalid ID - Should Fail
  Given path '/carts/99999'
  When method GET
  Then status 404
  And match response.error == 'Cart not found'

Scenario: Add item with invalid data - Should Fail
  Given path '/carts/add'
  And request { cartId: 'invalid', productId: -1, quantity: 0 }
  When method POST
  Then status 400
  And match response.error contains 'Invalid input data'

Scenario Outline: Data-driven cart creation - Should Pass
  Given path '/carts'
  And request { userId: '<userId>', items: [{ productId: '<productId>', quantity: <quantity>, price: <price> }] }
  When method POST
  Then status 201
  And match response.userId == <userId>
  And match response.totalQuantity == <quantity>

  Examples:
    | userId | productId | quantity | price  |
    | 123    | 101       | 2        | 29.99  |
    | 456    | 102       | 1        | 49.99  |
    | 789    | 103       | 3        | 19.99  |

Scenario: Validate cart totals consistency - Should Pass
  Given path '/carts/1'
  When method GET
  Then status 200
  And match response.total == response.items[*].price * response.items[*].quantity
  And match response.totalQuantity == response.items[*].quantity.sum()

Scenario: Validate discounted totals - Should Pass
  Given path '/carts/1/discount'
  When method GET
  Then status 200
  And match response.originalTotal > response.discountedTotal
  And match response.discountPercentage > 0
