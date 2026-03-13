Feature: Product Catalog API Tests
    Test product search, filtering, pagination, and category management

    @smoke @regression
    Scenario: Get all products list
        Given path endpoints.products.list
        When method get
        Then status 200
        And match response == '#[10]'
        And match each response == { 
            id: '#number', 
            title: '#string', 
            price: '#number', 
            category: '#string',
            description: '#string',
            image: '#string'
        }
        * def productCount = response.length
        * karate.log('Total products found:', productCount)

    @smoke @regression
    Scenario: Search products by keyword
        Given path endpoints.products.search
        And param q = 'electronics'
        When method get
        Then status 200
        And match response == '#[1..]'
        And match each response.category contains 'electronics'
        * def searchResults = response.length
        * karate.log('Products found for "electronics":', searchResults)

    @regression
    Scenario Outline: Search products with different keywords
        Given path endpoints.products.search
        And param q = '<keyword>'
        When method get
        Then status 200
        And match response == '#[0..]'
        * def resultCount = response.length
        * karate.log('Products found for "<keyword>":', resultCount)

        Examples:
            | keyword       |
            | laptop        |
            | phone         |
            | clothing      |
            | book          |
            | nonexistent   |

    @regression
    Scenario: Filter products by category
        Given path endpoints.products.list
        And param category = 'electronics'
        When method get
        Then status 200
        And match response == '#[1..]'
        And match each response.category == 'electronics'
        * def filteredProducts = response.length
        * karate.log('Electronics products:', filteredProducts)

    @regression
    Scenario Outline: Filter products by price range
        Given path endpoints.products.list
        And param minPrice = '<minPrice>'
        And param maxPrice = '<maxPrice>'
        When method get
        Then status 200
        And match response == '#[0..]'
        And match each response.price >= <minPrice>
        And match each response.price <= <maxPrice>
        * def priceFilteredCount = response.length
        * karate.log('Products between <minPrice> and <maxPrice>:', priceFilteredCount)

        Examples:
            | minPrice | maxPrice |
            | 0        | 50       |
            | 50       | 100      |
            | 100      | 500      |
            | 500      | 1000     |

    @smoke
    Scenario: Product pagination functionality
        Given path endpoints.products.list
        And param page = 1
        And param limit = 5
        When method get
        Then status 200
        And match response == '#[5]'
        And match response.metadata == { 
            page: 1, 
            limit: 5, 
            total: '#number', 
            totalPages: '#number',
            hasNext: '#boolean',
            hasPrev: '#boolean'
        }
        * def firstPage = response
        * def totalCount = response.metadata.total
        * karate.log('Total products available:', totalCount)

    @regression
    Scenario Outline: Test different page sizes
        Given path endpoints.products.list
        And param page = <page>
        And param limit = <limit>
        When method get
        Then status 200
        And match response == '#[<expectedCount>]'
        And match response.metadata.page == <page>
        And match response.metadata.limit == <limit>

        Examples:
            | page | limit | expectedCount |
            | 1    | 10    | 10            |
            | 1    | 20    | 20            |
            | 2    | 5     | 5             |
            | 1    | 100   | 100           |

    @smoke
    Scenario: Get product details by ID
        Given path endpoints.products.details + '1'
        When method get
        Then status 200
        And match response == { 
            id: 1, 
            title: '#string', 
            price: '#number', 
            category: '#string',
            description: '#string',
            image: '#string',
            rating: { rate: '#number', count: '#number' }
        }
        * def productId = response.id
        * karate.log('Product details retrieved for ID:', productId)

    @regression
    Scenario: Get details for non-existent product
        Given path endpoints.products.details + '99999'
        When method get
        Then status 404
        And match response == { error: { message: '#string', code: 'PRODUCT_NOT_FOUND' } }

    @regression
    Scenario: Sort products by price ascending
        Given path endpoints.products.list
        And param sort = 'price'
        And param order = 'asc'
        When method get
        Then status 200
        And match response == '#[1..]'
        * def prices = karate.map(response, '$.price')
        * for (i = 1; i < prices.length; i++)
            * match prices[i] >= prices[i-1]

    @regression
    Scenario: Sort products by price descending
        Given path endpoints.products.list
        And param sort = 'price'
        And param order = 'desc'
        When method get
        Then status 200
        And match response == '#[1..]'
        * def prices = karate.map(response, '$.price')
        * for (i = 1; i < prices.length; i++)
            * match prices[i] <= prices[i-1]

    @regression
    Scenario: Get product categories
        Given path endpoints.products.categories
        When method get
        Then status 200
        And match response == '#[3..]'
        And match each response == '#string'
        * def categories = response
        * karate.log('Available categories:', categories)

    @regression
    Scenario: Search with multiple filters
        Given path endpoints.products.search
        And param q = 'phone'
        And param category = 'electronics'
        And param minPrice = 100
        And param maxPrice = 1000
        When method get
        Then status 200
        And match response == '#[0..]'
        And match each response.category == 'electronics'
        And match each response.title contains 'phone'
        And match each response.price >= 100
        And match each response.price <= 1000
        * def multiFilterCount = response.length
        * karate.log('Products matching all filters:', multiFilterCount)

    @performance
    Scenario: Performance test for product search
        * def searchQueries = ['laptop', 'phone', 'tablet', 'watch', 'headphones']
        * def searchTimes = []
        * for (i = 0; i < searchQueries.length; i++)
            * def startTime = new Date().getTime()
            Given path endpoints.products.search
            And param q = searchQueries[i]
            When method get
            Then status 200
            * def endTime = new Date().getTime()
            * def responseTime = endTime - startTime
            * searchTimes.push(responseTime)
            * karate.log('Search for "' + searchQueries[i] + '" took:', responseTime, 'ms')
        * def avgSearchTime = searchTimes.reduce((sum, time) => sum + time, 0) / searchTimes.length
        * karate.log('Average search time:', avgSearchTime, 'ms')
        * match avgSearchTime < 500
