Feature: Inventory Management API Testing
  As an e-commerce administrator
  I want to manage product inventory
  So that stock levels are accurate

Background:
  * url 'https://api.ossjavahub.com'
  * header Content-Type = 'application/json'
  * header Accept = 'application/json'

Scenario: Get all inventory - Should Pass
  Given path '/inventory'
  When method GET
  Then status 200
  And match response[*] contains { productId: '#number', stock: '#number', reserved: '#number', available: '#number' }
  And match response[0].available == response[0].stock - response[0].reserved

Scenario: Get inventory by product ID - Should Pass
  Given path '/inventory/101'
  When method GET
  Then status 200
  And match response.productId == 101
  And match response.stock >= 0
  And match response.reserved >= 0
  And match response.available >= 0

Scenario: Update stock levels - Should Pass
  Given path '/inventory/101/stock'
  And request { stock: 100, reason: 'Restock' }
  When method PUT
  Then status 200
  And match response.stock == 100
  And match response.success == true

Scenario: Reserve inventory - Should Pass
  Given path '/inventory/101/reserve'
  And request { quantity: 5, orderId: 1001 }
  When method POST
  Then status 200
  And match response.reserved == 5
  And match response.available == response.stock - 5

Scenario: Release inventory - Should Pass
  Given path '/inventory/101/release'
  And request { quantity: 3, orderId: 1001 }
  When method POST
  Then status 200
  And match response.reserved == 2
  And match response.available == response.stock - 2

Scenario: Get low stock alerts - Should Pass
  Given path '/inventory/alerts/low-stock'
  When method GET
  Then status 200
  And match response[*].stock <= 10
  And match response[*].productId == '#number'

Scenario: Get inventory report - Should Pass
  Given path '/inventory/report'
  When method GET
  Then status 200
  And match response.totalProducts == '#number'
  And match response.totalStock == '#number'
  And match response.totalReserved == '#number'
  And match response.totalAvailable == '#number'

Scenario: Update inventory with invalid data - Should Fail
  Given path '/inventory/101/stock'
  And request { stock: -1, reason: 'Invalid' }
  When method POST
  Then status 400
  And match response.error contains 'Invalid stock quantity'

Scenario: Reserve more than available - Should Fail
  Given path '/inventory/101/reserve'
  And request { quantity: 999, orderId: 1001 }
  When method POST
  Then status 400
  And match response.error contains 'Insufficient stock'

Scenario: Get non-existent inventory - Should Fail
  Given path '/inventory/99999'
  When method GET
  Then status 404
  And match response.error == 'Product not found'

Scenario Outline: Data-driven stock updates - Should Pass
  Given path '/inventory/<productId>/stock'
  And request { stock: <stock>, reason: '<reason>' }
  When method PUT
  Then status 200
  And match response.stock == <stock>

  Examples:
    | productId | stock | reason          |
    | 101       | 50    | 'Initial stock' |
    | 102       | 100   | 'Restock'       |
    | 103       | 25    | 'Adjustment'    |

Scenario: Validate inventory calculations - Should Pass
  Given path '/inventory/101'
  When method GET
  Then status 200
  And match response.available == response.stock - response.reserved
  And match response.stock >= response.reserved
