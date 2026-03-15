Feature: Payment Processing API Testing
  As an e-commerce customer
  I want to process payments securely
  So that I can complete transactions

Background:
  * url 'https://api.ossjavahub.com'
  * header Content-Type = 'application/json'
  * header Accept = 'application/json'

Scenario: Process payment - Should Pass
  Given path '/payments/process'
  And request { orderId: 1001, amount: 59.98, paymentMethod: 'credit_card', cardInfo: { number: '4111111111111111', expiry: '12/25', cvv: '123' } }
  When method POST
  Then status 200
  And match response.success == true
  And match response.paymentId == '#number'
  And match response.transactionId == '#string'
  And match response.status == 'completed'

Scenario: Get payment by ID - Should Pass
  Given path '/payments/5001'
  When method GET
  Then status 200
  And match response.paymentId == 5001
  And match response.orderId == '#number'
  And match response.amount > 0
  And match response.status == '#string'

Scenario: Get payments by order ID - Should Pass
  Given path '/payments/order/1001'
  When method GET
  Then status 200
  And match response[*].orderId == 1001
  And match response[*].amount > 0

Scenario: Process refund - Should Pass
  Given path '/payments/5001/refund'
  And request { reason: 'Customer request', amount: 59.98 }
  When method POST
  Then status 200
  And match response.success == true
  And match response.refundId == '#number'
  And match response.status == 'processed'

Scenario: Get payment methods - Should Pass
  Given path '/payments/methods'
  When method GET
  Then status 200
  And match response[*] contains { type: '#string', name: '#string', enabled: '#boolean' }
  And match response[?(@.type == 'credit_card')].enabled == true

Scenario: Validate payment amount - Should Pass
  Given path '/payments/validate'
  And request { orderId: 1001, amount: 59.98 }
  When method POST
  Then status 200
  And match response.valid == true
  And match response.expectedAmount == 59.98

Scenario: Process payment with invalid card - Should Fail
  Given path '/payments/process'
  And request { orderId: 1001, amount: 59.98, paymentMethod: 'credit_card', cardInfo: { number: 'invalid', expiry: '12/25', cvv: '123' } }
  When method POST
  Then status 400
  And match response.error contains 'Invalid card information'

Scenario: Process payment with insufficient funds - Should Fail
  Given path '/payments/process'
  And request { orderId: 1001, amount: 99999.99, paymentMethod: 'credit_card', cardInfo: { number: '4111111111111111', expiry: '12/25', cvv: '123' } }
  When method POST
  Then status 402
  And match response.error == 'Insufficient funds'

Scenario: Get non-existent payment - Should Fail
  Given path '/payments/99999'
  When method GET
  Then status 404
  And match response.error == 'Payment not found'

Scenario Outline: Data-driven payment processing - Should Pass/Fail
  Given path '/payments/process'
  And request { orderId: <orderId>, amount: <amount>, paymentMethod: '<method>', cardInfo: { number: '<cardNumber>', expiry: '<expiry>', cvv: '<cvv>' } }
  When method POST
  Then status <status>
  And match response contains { <responseField>: '<responseValue>' }

  Examples:
    | orderId | amount  | method        | cardNumber           | expiry  | cvv  | status | responseField | responseValue |
    | 1001    | 59.98   | credit_card   | 4111111111111111     | 12/25   | 123  | 200    | success       | true          |
    | 1002    | 99.99   | debit_card    | 4111111111111111     | 11/24   | 456  | 200    | success       | true          |
    | 1003    | 0.00    | credit_card   | 4111111111111111     | 12/25   | 123  | 400    | error         | Invalid amount |
    | 1004    | 59.98   | credit_card   | invalid               | 12/25   | 123  | 400    | error         | Invalid card   |
