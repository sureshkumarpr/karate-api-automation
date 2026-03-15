Feature: Product Catalog API Testing
  As an e-commerce customer
  I want to browse and search products
  So that I can find items to purchase

Background:
  * url 'https://api.ossjavahub.com'
  * header Content-Type = 'application/json'
  * header Accept = 'application/json'

Scenario: Get all products - Should Pass
  Given path '/products'
  When method GET
  Then status 200
  And match response[*] contains { id: '#number', name: '#string', price: '#number', stock: '#number' }
  And match response[0].price > 0

Scenario: Get product by ID - Should Pass
  Given path '/products/101'
  When method GET
  Then status 200
  And match response.id == 101
  And match response.name == '#string'
  And match response.price > 0
  And match response.stock >= 0

Scenario: Search products by category - Should Pass
  Given path '/products/search'
  And param category = 'electronics'
  When method GET
  Then status 200
  And match response[*].category == 'electronics'
  And match response[*].name contains 'phone'

Scenario: Get products by price range - Should Pass
  Given path '/products/search'
  And param minPrice = 50
  And param maxPrice = 200
  When method GET
  Then status 200
  And match response[*].price >= 50
  And match response[*].price <= 200

Scenario: Get featured products - Should Pass
  Given path '/products/featured'
  When method GET
  Then status 200
  And match response[*].featured == true
  And match response[*].discount > 0

Scenario: Get product with invalid ID - Should Fail
  Given path '/products/99999'
  When method GET
  Then status 404
  And match response.error == 'Product not found'

Scenario: Search with invalid category - Should Fail
  Given path '/products/search'
  And param category = 'invalid-category'
  When method GET
  Then status 400
  And match response.error contains 'Invalid category'

Scenario Outline: Data-driven product search - Should Pass
  Given path '/products/search'
  And param keyword = '<keyword>'
  And param category = '<category>'
  When method GET
  Then status 200
  And match response[*].name contains '<keyword>'

  Examples:
    | keyword   | category    |
    | laptop    | electronics |
    | shirt     | clothing    |
    | book      | education   |
