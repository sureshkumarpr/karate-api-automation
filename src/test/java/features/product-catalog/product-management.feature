Feature: Product Management API Tests
    Test product CRUD operations for admin users

    @smoke @regression
    Scenario: Create new product (Admin only)
        * def loginResult = call read('classpath:features/authentication/login.feature@Successful user login with valid credentials')
        * def adminToken = loginResult.authToken
        * def productData = call read('classpath:features/common/common.feature@Generate Random Product Data').productData
        Given path endpoints.products.list
        And header Authorization = 'Bearer ' + adminToken
        And request productData
        When method post
        Then status 201
        And match response == { 
            id: '#number', 
            title: productData.title, 
            price: productData.price, 
            category: productData.category,
            description: productData.description,
            message: 'Product created successfully'
        }
        * def newProductId = response.id
        * karate.log('Product created with ID:', newProductId)

    @regression
    Scenario: Create product without authentication should fail
        * def productData = call read('classpath:features/common/common.feature@Generate Random Product Data').productData
        Given path endpoints.products.list
        And request productData
        When method post
        Then status 401
        And match response == { error: { message: '#string', code: 'UNAUTHORIZED' } }

    @regression
    Scenario Outline: Create product validation
        * def loginResult = call read('classpath:features/authentication/login.feature@Successful user login with valid credentials')
        * def adminToken = loginResult.authToken
        Given path endpoints.products.list
        And header Authorization = 'Bearer ' + adminToken
        And request
        """
        {
            title: '<title>',
            price: <price>,
            category: '<category>',
            description: '<description>'
        }
        """
        When method post
        Then status <status>
        And match response == { error: { message: '#string', field: '<field>', code: '<errorCode>' } }

        Examples:
            | title | price | category | description | status | field     | errorCode           |
            |       | 99.99 | electronics | Test desc  | 400    | title    | MISSING_TITLE       |
            | Test  |       | electronics | Test desc  | 400    | price    | MISSING_PRICE       |
            | Test  | 99.99 |            | Test desc  | 400    | category | MISSING_CATEGORY    |
            | Test  | -10   | electronics | Test desc  | 400    | price    | INVALID_PRICE       |
            | Test  | 0     | electronics | Test desc  | 400    | price    | INVALID_PRICE       |

    @regression
    Scenario: Update product details (Admin only)
        * def loginResult = call read('classpath:features/authentication/login.feature@Successful user login with valid credentials')
        * def adminToken = loginResult.authToken
        * def productData = call read('classpath:features/common/common.feature@Generate Random Product Data').productData
        Given path endpoints.products.details + '1'
        And header Authorization = 'Bearer ' + adminToken
        And request { price: 299.99, description: 'Updated product description' }
        When method put
        Then status 200
        And match response == { 
            id: 1, 
            title: '#string', 
            price: 299.99, 
            category: '#string',
            description: 'Updated product description',
            message: 'Product updated successfully'
        }

    @regression
    Scenario: Update product without authentication should fail
        Given path endpoints.products.details + '1'
        And request { price: 199.99 }
        When method put
        Then status 401
        And match response == { error: { message: '#string', code: 'UNAUTHORIZED' } }

    @regression
    Scenario: Delete product (Admin only)
        * def loginResult = call read('classpath:features/authentication/login.feature@Successful user login with valid credentials')
        * def adminToken = loginResult.authToken
        # First create a product to delete
        * def productData = call read('classpath:features/common/common.feature@Generate Random Product Data').productData
        Given path endpoints.products.list
        And header Authorization = 'Bearer ' + adminToken
        And request productData
        When method post
        Then status 201
        * def productIdToDelete = response.id
        # Now delete the product
        Given path endpoints.products.details + productIdToDelete
        And header Authorization = 'Bearer ' + adminToken
        When method delete
        Then status 200
        And match response == { message: 'Product deleted successfully' }
        * karate.log('Product deleted with ID:', productIdToDelete)

    @regression
    Scenario: Delete product without authentication should fail
        Given path endpoints.products.details + '1'
        When method delete
        Then status 401
        And match response == { error: { message: '#string', code: 'UNAUTHORIZED' } }

    @regression
    Scenario: Delete non-existent product
        * def loginResult = call read('classpath:features/authentication/login.feature@Successful user login with valid credentials')
        * def adminToken = loginResult.authToken
        Given path endpoints.products.details + '99999'
        And header Authorization = 'Bearer ' + adminToken
        When method delete
        Then status 404
        And match response == { error: { message: '#string', code: 'PRODUCT_NOT_FOUND' } }

    @regression
    Scenario: Bulk product operations (Admin only)
        * def loginResult = call read('classpath:features/authentication/login.feature@Successful user login with valid credentials')
        * def adminToken = loginResult.authToken
        * def productsToCreate = []
        * for (i = 0; i < 3; i++)
            * def productData = call read('classpath:features/common/common.feature@Generate Random Product Data').productData
            * productsToCreate.push(productData)
        Given path '/products/bulk'
        And header Authorization = 'Bearer ' + adminToken
        And request { products: productsToCreate }
        When method post
        Then status 201
        And match response == { 
            message: 'Bulk products created successfully',
            created: '#[3]',
            failed: '#[]'
        }
        * def createdCount = response.created.length
        * karate.log('Bulk created', createdCount, 'products')

    @regression
    Scenario: Product inventory management
        * def loginResult = call read('classpath:features/authentication/login.feature@Successful user login with valid credentials')
        * def adminToken = loginResult.authToken
        Given path endpoints.products.details + '1/inventory'
        And header Authorization = 'Bearer ' + adminToken
        And request { quantity: 100, lowStockThreshold: 10 }
        When method put
        Then status 200
        And match response == { 
            productId: 1,
            quantity: 100,
            lowStockThreshold: 10,
            inStock: true,
            message: 'Inventory updated successfully'
        }

    @regression
    Scenario: Check product availability
        Given path endpoints.products.details + '1/availability'
        When method get
        Then status 200
        And match response == { 
            productId: 1,
            inStock: '#boolean',
            quantity: '#number',
            nextRestockDate: '#string?'
        }
