const fs = require('fs');
const path = require('path');

// HTML Report Template (based on your karate-summary_1.html)
const reportTemplate = `<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>E-commerce API Test Automation Report</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            line-height: 1.6;
            color: #333;
            background-color: #f5f5f5;
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        
        .header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 40px 0;
            text-align: center;
            border-radius: 10px;
            margin-bottom: 30px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }
        
        .header h1 {
            font-size: 2.5em;
            margin-bottom: 10px;
        }
        
        .header p {
            font-size: 1.2em;
            opacity: 0.9;
        }
        
        .summary-cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        
        .card {
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            text-align: center;
            transition: transform 0.3s ease;
        }
        
        .card:hover {
            transform: translateY(-5px);
        }
        
        .card.success {
            border-left: 5px solid #28a745;
        }
        
        .card.danger {
            border-left: 5px solid #dc3545;
        }
        
        .card.warning {
            border-left: 5px solid #ffc107;
        }
        
        .card.info {
            border-left: 5px solid #17a2b8;
        }
        
        .card h3 {
            font-size: 2.5em;
            margin-bottom: 10px;
            font-weight: bold;
        }
        
        .card p {
            color: #666;
            font-size: 1.1em;
        }
        
        .test-section {
            background: white;
            margin-bottom: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            overflow: hidden;
        }
        
        .section-header {
            background: #f8f9fa;
            padding: 20px;
            border-bottom: 1px solid #dee2e6;
        }
        
        .section-header h2 {
            color: #495057;
            font-size: 1.5em;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .section-header .badge {
            background: #007bff;
            color: white;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 0.8em;
        }
        
        .test-table {
            width: 100%;
            border-collapse: collapse;
        }
        
        .test-table th,
        .test-table td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #dee2e6;
        }
        
        .test-table th {
            background: #f8f9fa;
            font-weight: 600;
            color: #495057;
        }
        
        .test-table tr:hover {
            background: #f8f9fa;
        }
        
        .status-badge {
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 0.85em;
            font-weight: 600;
            text-transform: uppercase;
        }
        
        .status-passed {
            background: #d4edda;
            color: #155724;
        }
        
        .status-failed {
            background: #f8d7da;
            color: #721c24;
        }
        
        .status-skipped {
            background: #fff3cd;
            color: #856404;
        }
        
        .tag {
            display: inline-block;
            padding: 2px 8px;
            margin: 2px;
            border-radius: 12px;
            font-size: 0.75em;
            background: #e9ecef;
            color: #495057;
        }
        
        .tag.smoke {
            background: #d1ecf1;
            color: #0c5460;
        }
        
        .tag.regression {
            background: #f8d7da;
            color: #721c24;
        }
        
        .tag.performance {
            background: #d4edda;
            color: #155724;
        }
        
        .duration {
            color: #6c757d;
            font-family: 'Courier New', monospace;
        }
        
        .footer {
            text-align: center;
            padding: 30px;
            color: #6c757d;
            border-top: 1px solid #dee2e6;
            margin-top: 40px;
        }
        
        .charts {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        
        .chart-card {
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        
        .chart-card h3 {
            margin-bottom: 15px;
            color: #495057;
        }
        
        .mini-chart {
            height: 200px;
            display: flex;
            align-items: flex-end;
            justify-content: space-around;
            gap: 10px;
        }
        
        .chart-bar {
            flex: 1;
            background: linear-gradient(180deg, #007bff, #0056b3);
            border-radius: 4px 4px 0 0;
            position: relative;
            min-height: 20px;
        }
        
        .chart-label {
            position: absolute;
            bottom: -25px;
            left: 50%;
            transform: translateX(-50%);
            font-size: 0.8em;
            color: #6c757d;
        }
        
        .chart-value {
            position: absolute;
            top: -25px;
            left: 50%;
            transform: translateX(-50%);
            font-size: 0.9em;
            font-weight: bold;
            color: #495057;
        }
        
        @media (max-width: 768px) {
            .container {
                padding: 10px;
            }
            
            .header h1 {
                font-size: 2em;
            }
            
            .summary-cards {
                grid-template-columns: 1fr;
            }
            
            .test-table {
                font-size: 0.9em;
            }
            
            .test-table th,
            .test-table td {
                padding: 10px 5px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>🚀 E-commerce API Test Automation Report</h1>
            <p>Comprehensive Test Execution Results • Generated on {{DATE}}</p>
            <p>Environment: {{ENVIRONMENT}} • Framework: Karate {{KARATE_VERSION}} • Duration: {{DURATION}}</p>
        </div>

        <div class="summary-cards">
            <div class="card success">
                <h3>{{PASSED_TESTS}}</h3>
                <p>Tests Passed</p>
            </div>
            <div class="card danger">
                <h3>{{FAILED_TESTS}}</h3>
                <p>Tests Failed</p>
            </div>
            <div class="card warning">
                <h3>{{SKIPPED_TESTS}}</h3>
                <p>Tests Skipped</p>
            </div>
            <div class="card info">
                <h3>{{SUCCESS_RATE}}%</h3>
                <p>Success Rate</p>
            </div>
        </div>

        <div class="charts">
            <div class="chart-card">
                <h3>📊 Test Results by Category</h3>
                <div class="mini-chart">
                    {{CATEGORY_CHART}}
                </div>
            </div>
            
            <div class="chart-card">
                <h3>⏱️ Execution Time Distribution</h3>
                <div class="mini-chart">
                    {{TIME_CHART}}
                </div>
            </div>
        </div>

        {{TEST_SECTIONS}}

        <div class="footer">
            <p>Generated by Karate API Test Automation Suite • {{TIMESTAMP}}</p>
            <p>© 2026 E-commerce Test Automation Framework</p>
        </div>
    </div>
</body>
</html>`;

// Mock test data (replace with actual test results)
function generateMockTestData() {
    return {
        date: new Date().toLocaleDateString('en-US', { year: 'numeric', month: 'long', day: 'numeric' }),
        environment: 'Development',
        karateVersion: '1.4.1',
        duration: '4m 32s',
        timestamp: new Date().toISOString(),
        passedTests: 47,
        failedTests: 3,
        skippedTests: 2,
        successRate: 94,
        categoryChart: `
            <div class="chart-bar" style="height: 85%;">
                <span class="chart-value">17</span>
                <span class="chart-label">Auth</span>
            </div>
            <div class="chart-bar" style="height: 95%;">
                <span class="chart-value">19</span>
                <span class="chart-label">Products</span>
            </div>
            <div class="chart-bar" style="height: 90%;">
                <span class="chart-value">9</span>
                <span class="chart-label">Cart</span>
            </div>
            <div class="chart-bar" style="height: 80%;">
                <span class="chart-value">7</span>
                <span class="chart-label">Checkout</span>
            </div>
        `,
        timeChart: `
            <div class="chart-bar" style="height: 60%; background: linear-gradient(180deg, #28a745, #20c997);">
                <span class="chart-value">1.2s</span>
                <span class="chart-label">Fast</span>
            </div>
            <div class="chart-bar" style="height: 85%; background: linear-gradient(180deg, #ffc107, #e0a800);">
                <span class="chart-value">2.8s</span>
                <span class="chart-label">Medium</span>
            </div>
            <div class="chart-bar" style="height: 95%; background: linear-gradient(180deg, #dc3545, #c82333);">
                <span class="chart-value">5.1s</span>
                <span class="chart-label">Slow</span>
            </div>
        `,
        testSections: generateTestSections()
    };
}

function generateTestSections() {
    const sections = [
        {
            title: '🔐 Authentication Tests',
            count: 17,
            tests: [
                { name: 'Successful user login with valid credentials', status: 'PASSED', duration: '1.23s', tags: ['@smoke', '@regression'], error: '-' },
                { name: 'Login attempt with invalid credentials should fail', status: 'PASSED', duration: '0.89s', tags: ['@regression'], error: '-' },
                { name: 'Token validation and session expiry', status: 'PASSED', duration: '2.12s', tags: ['@smoke'], error: '-' },
                { name: 'Session timeout test', status: 'FAILED', duration: '3.21s', tags: ['@regression'], error: 'Token expiry not handled correctly' },
                { name: 'OAuth integration test', status: 'SKIPPED', duration: '-', tags: ['@regression'], error: 'OAuth service unavailable' }
            ]
        },
        {
            title: '🛍️ Product Catalog Tests',
            count: 19,
            tests: [
                { name: 'Get all products list', status: 'PASSED', duration: '0.98s', tags: ['@smoke', '@regression'], error: '-' },
                { name: 'Search products by keyword', status: 'PASSED', duration: '1.12s', tags: ['@smoke', '@regression'], error: '-' },
                { name: 'Product pagination functionality', status: 'PASSED', duration: '1.78s', tags: ['@smoke'], error: '-' },
                { name: 'Create new product (Admin only)', status: 'PASSED', duration: '2.67s', tags: ['@smoke', '@regression'], error: '-' },
                { name: 'Product image upload test', status: 'FAILED', duration: '4.23s', tags: ['@regression'], error: 'Image service timeout' }
            ]
        },
        {
            title: '🛒 Shopping Cart Tests',
            count: 9,
            tests: [
                { name: 'Get user cart (empty cart)', status: 'PASSED', duration: '1.12s', tags: ['@smoke', '@regression'], error: '-' },
                { name: 'Add item to cart', status: 'PASSED', duration: '1.67s', tags: ['@smoke', '@regression'], error: '-' },
                { name: 'Update cart item quantity', status: 'PASSED', duration: '1.56s', tags: ['@regression'], error: '-' },
                { name: 'Remove item from cart', status: 'PASSED', duration: '1.23s', tags: ['@regression'], error: '-' },
                { name: 'Performance test for cart operations', status: 'PASSED', duration: '5.67s', tags: ['@performance'], error: '-' }
            ]
        },
        {
            title: '💳 Checkout & Order Tests',
            count: 7,
            tests: [
                { name: 'Complete checkout process with valid payment', status: 'PASSED', duration: '3.45s', tags: ['@smoke', '@regression'], error: '-' },
                { name: 'Checkout with empty cart should fail', status: 'PASSED', duration: '1.23s', tags: ['@regression'], error: '-' },
                { name: 'Payment method validation', status: 'PASSED', duration: '2.67s', tags: ['@regression'], error: '-' },
                { name: 'Credit card validation', status: 'PASSED', duration: '1.98s', tags: ['@regression'], error: '-' },
                { name: 'Payment failure simulation', status: 'PASSED', duration: '2.89s', tags: ['@regression'], error: '-' }
            ]
        }
    ];

    return sections.map(section => `
        <div class="test-section">
            <div class="section-header">
                <h2>${section.title} <span class="badge">${section.count} scenarios</span></h2>
            </div>
            <table class="test-table">
                <thead>
                    <tr>
                        <th>Scenario</th>
                        <th>Status</th>
                        <th>Duration</th>
                        <th>Tags</th>
                        <th>Error</th>
                    </tr>
                </thead>
                <tbody>
                    ${section.tests.map(test => `
                        <tr>
                            <td>${test.name}</td>
                            <td><span class="status-badge status-${test.status.toLowerCase()}">${test.status}</span></td>
                            <td class="duration">${test.duration}</td>
                            <td>${test.tags.map(tag => `<span class="tag ${tag.replace('@', '')}">${tag}</span>`).join(' ')}</td>
                            <td>${test.error}</td>
                        </tr>
                    `).join('')}
                </tbody>
            </table>
        </div>
    `).join('');
}

function generateReport() {
    const testData = generateMockTestData();
    
    let html = reportTemplate;
    
    // Replace placeholders with actual data
    html = html.replace('{{DATE}}', testData.date);
    html = html.replace('{{ENVIRONMENT}}', testData.environment);
    html = html.replace('{{KARATE_VERSION}}', testData.karateVersion);
    html = html.replace('{{DURATION}}', testData.duration);
    html = html.replace('{{TIMESTAMP}}', testData.timestamp);
    html = html.replace('{{PASSED_TESTS}}', testData.passedTests);
    html = html.replace('{{FAILED_TESTS}}', testData.failedTests);
    html = html.replace('{{SKIPPED_TESTS}}', testData.skippedTests);
    html = html.replace('{{SUCCESS_RATE}}', testData.successRate);
    html = html.replace('{{CATEGORY_CHART}}', testData.categoryChart);
    html = html.replace('{{TIME_CHART}}', testData.timeChart);
    html = html.replace('{{TEST_SECTIONS}}', testData.testSections);
    
    return html;
}

// Generate and save the report
const reportHtml = generateReport();
const outputPath = 'C:\\Users\\Suresh Kumar PR\\Documents\\Divya_Project\\karate-summary.html';

fs.writeFileSync(outputPath, reportHtml, 'utf8');
console.log(`Report generated successfully at: ${outputPath}`);

module.exports = { generateReport, generateMockTestData };
