Feature: Shipping Management API Testing
  As an e-commerce customer
  I want to track and manage shipping
  So that I can receive my orders

Background:
  * url 'https://api.ossjavahub.com'
  * header Content-Type = 'application/json'
  * header Accept = 'application/json'

Scenario: Get shipping rates - Should Pass
  Given path '/shipping/rates'
  And request { weight: 2.5, dimensions: { length: 10, width: 8, height: 5 }, fromZip: '600001', toZip: '400001' }
  When method POST
  Then status 200
  And match response[*] contains { carrier: '#string', service: '#string', rate: '#number', deliveryDays: '#number' }
  And match response[0].rate > 0

Scenario: Create shipping label - Should Pass
  Given path '/shipping/labels'
  And request { orderId: 1001, carrier: 'fedex', service: 'ground', address: { name: 'Test User', street: '123 Test St', city: 'Chennai', state: 'Tamilnadu', zip: '600001' } }
  When method POST
  Then status 201
  And match response.labelId == '#number'
  And match response.trackingNumber == '#string'
  And match response.carrier == 'fedex'

Scenario: Get tracking information - Should Pass
  Given path '/shipping/tracking/TRK123456789'
  When method GET
  Then status 200
  And match response.trackingNumber == 'TRK123456789'
  And match response.status == '#string'
  And match response.currentLocation == '#string'
  And match response.estimatedDelivery == '#string'

Scenario: Update shipping status - Should Pass
  Given path '/shipping/TRK123456789/status'
  And request { status: 'in_transit', location: 'Chennai Distribution Center', timestamp: '2026-03-15T10:00:00Z' }
  When method PUT
  Then status 200
  And match response.status == 'in_transit'
  And match response.location == 'Chennai Distribution Center'

Scenario: Get shipping history - Should Pass
  Given path '/shipping/TRK123456789/history'
  When method GET
  Then status 200
  And match response[*] contains { status: '#string', location: '#string', timestamp: '#string' }
  And match response[0].timestamp == '#string'

Scenario: Cancel shipment - Should Pass
  Given path '/shipping/labels/5001/cancel'
  When method POST
  Then status 200
  And match response.success == true
  And match response.message == 'Shipment cancelled'

Scenario: Get shipping methods - Should Pass
  Given path '/shipping/methods'
  When method GET
  Then status 200
  And match response[*] contains { id: '#string', name: '#string', description: '#string', estimatedDays: '#number' }
  And match response[*].estimatedDays > 0

Scenario: Calculate shipping cost - Should Pass
  Given path '/shipping/calculate'
  And request { orderId: 1001, method: 'standard', address: { zip: '600001', country: 'IN' } }
  When method POST
  Then status 200
  And match response.cost > 0
  And match response.estimatedDays > 0

Scenario: Create label with invalid address - Should Fail
  Given path '/shipping/labels'
  And request { orderId: 1001, carrier: 'fedex', service: 'ground', address: { name: '', street: '', city: '', state: '', zip: '' } }
  When method POST
  Then status 400
  And match response.error contains 'Invalid address'

Scenario: Get non-existent tracking - Should Fail
  Given path '/shipping/tracking/INVALID123'
  When method GET
  Then status 404
  And match response.error == 'Tracking number not found'

Scenario Outline: Data-driven shipping rate calculation - Should Pass
  Given path '/shipping/rates'
  And request { weight: <weight>, dimensions: { length: <length>, width: <width>, height: <height> }, fromZip: '<fromZip>', toZip: '<toZip>' }
  When method POST
  Then status 200
  And match response[*].rate > 0

  Examples:
    | weight | length | width | height | fromZip | toZip |
    | 1.0    | 8      | 6     | 4      | '600001' | '400001' |
    | 2.5    | 10     | 8     | 5      | '600001' | '110001' |
    | 5.0    | 12     | 10    | 8      | '600001' | '560001' |

Scenario: Validate tracking status flow - Should Pass
  Given path '/shipping/tracking/TRK123456789'
  When method GET
  Then status 200
  And match response.status contains 'pending|in_transit|out_for_delivery|delivered'
  And match response.estimatedDelivery contains '#string'
