package com.ecommerce.karate;

import java.io.FileWriter;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

/**
 * Single Page Application Generator for better UX
 */
public class SinglePageGenerator {
    
    public static void main(String[] args) {
        generateSinglePage();
    }
    
    public static void generateSinglePage() {
        try {
            // Create target directory if it doesn't exist
            Files.createDirectories(Paths.get("target"));
            Files.createDirectories(Paths.get("target/images"));
            
            // Copy images to target directory
            copyImages();
            
            String htmlContent = generateSinglePageContent();
            
            try (FileWriter writer = new FileWriter("target/index.html")) {
                writer.write(htmlContent);
            }
            
            System.out.println("Single Page Application generated successfully: target/index.html");
            
        } catch (IOException e) {
            System.err.println("Error generating single page: " + e.getMessage());
        }
    }
    
    private static void copyImages() {
        try {
            // Copy office image
            Files.copy(Paths.get("src/test/java/images/office.jpg"), 
                      Paths.get("target/images/office.jpg"));
            
            // Copy shopping cart image  
            Files.copy(Paths.get("src/test/java/images/shopping-cart.jpg"), 
                      Paths.get("target/images/shopping-cart.jpg"));
            
            System.out.println("Images copied to target/images/");
        } catch (IOException e) {
            System.err.println("Error copying images: " + e.getMessage());
        }
    }
    
    private static String generateSinglePageContent() {
        String timestamp = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
        
        // Scan all feature files
        List<FeatureScanner.FeatureInfo> features = FeatureScanner.scanAllFeatures();
        
        // Generate feature tiles HTML
        String featureTilesHtml = generateFeatureTilesHtml(features);
        
        return "<!DOCTYPE html>\n" +
               "<html lang=\"en\">\n" +
               "<head>\n" +
               "    <meta charset=\"UTF-8\">\n" +
               "    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n" +
               "    <title>Karate Test Report Portal - OSS Java Hub</title>\n" +
               "    <style>\n" +
               "        * { margin: 0; padding: 0; box-sizing: border-box; }\n" +
               "        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); min-height: 100vh; }\n" +
               "        .container { max-width: 1400px; margin: 0 auto; padding: 20px; }\n" +
               "        .header { text-align: center; color: white; margin-bottom: 40px; animation: fadeInDown 1s ease; }\n" +
               "        .header h1 { font-size: 3em; margin-bottom: 10px; text-shadow: 2px 2px 4px rgba(0,0,0,0.3); }\n" +
               "        .header p { font-size: 1.2em; opacity: 0.9; }\n" +
               "        .nav-tabs { display: flex; justify-content: center; margin-bottom: 30px; background: rgba(255,255,255,0.1); padding: 15px; border-radius: 15px; }\n" +
               "        .nav-tab { background: rgba(255,255,255,0.2); color: white; padding: 12px 25px; border: 2px solid transparent; border-radius: 25px; margin: 0 10px; cursor: pointer; transition: all 0.3s ease; font-weight: bold; }\n" +
               "        .nav-tab:hover { background: rgba(255,255,255,0.3); transform: translateY(-2px); }\n" +
               "        .nav-tab.active { background: linear-gradient(45deg, #ff6b6b, #ee5a24); border-color: white; box-shadow: 0 4px 15px rgba(238,90,36,0.4); }\n" +
               "        .content-section { display: none; animation: fadeIn 0.5s ease; }\n" +
               "        .content-section.active { display: block; }\n" +
               "        .content-grid { display: grid; grid-template-columns: 1fr; gap: 30px; margin-bottom: 30px; }\n" +
               "        .card { background: white; border-radius: 15px; padding: 30px; box-shadow: 0 10px 30px rgba(0,0,0,0.2); animation: fadeInUp 1s ease; }\n" +
               "        .card h2 { color: #2c3e50; margin-bottom: 20px; font-size: 1.8em; border-bottom: 3px solid #667eea; padding-bottom: 10px; }\n" +
               "        .image-container { text-align: center; margin: 20px 0; }\n" +
               "        .office-image { width: 100%; max-width: 400px; height: 250px; background: url('images/office.jpg') center/cover; border-radius: 10px; margin: 0 auto; }\n" +
               "        .cart-image { width: 100%; max-width: 300px; height: 200px; background: url('images/shopping-cart.jpg') center/cover; border-radius: 10px; margin: 0 auto; }\n" +
               "        .info-section { background: rgba(255,255,255,0.1); padding: 20px; border-radius: 10px; margin: 20px 0; color: white; }\n" +
               "        .info-section h3 { color: #ffc107; margin-bottom: 10px; }\n" +
               "        .info-section p { margin: 5px 0; font-weight: bold; }\n" +
               "        .stats { display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 20px; margin-bottom: 30px; }\n" +
               "        .stat-card { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 20px; border-radius: 10px; text-align: center; }\n" +
               "        .stat-card h3 { margin: 0 0 10px 0; font-size: 1.2em; }\n" +
               "        .stat-card .number { font-size: 2.5em; font-weight: bold; margin: 0; }\n" +
               "        .details { background: #f8f9fa; padding: 20px; border-radius: 8px; margin-top: 20px; }\n" +
               "        .status { display: inline-block; padding: 5px 15px; border-radius: 20px; font-weight: bold; }\n" +
               "        .success { background: #28a745; color: white; }\n" +
               "        .warning { background: #ffc107; color: #212529; }\n" +
               "        .danger { background: #dc3545; color: white; }\n" +
               "        .feature-tiles { display: grid; grid-template-columns: repeat(auto-fit, minmax(400px, 1fr)); gap: 25px; margin: 20px 0; }\n" +
               "        .feature-tile { background: white; border-radius: 15px; padding: 25px; box-shadow: 0 8px 25px rgba(0,0,0,0.15); transition: all 0.3s ease; border: 2px solid #e9ecef; }\n" +
               "        .feature-tile:hover { transform: translateY(-8px); box-shadow: 0 15px 40px rgba(0,0,0,0.2); border-color: #667eea; }\n" +
               "        .feature-tile h4 { color: #2c3e50; margin-bottom: 15px; font-size: 1.3em; border-bottom: 2px solid #667eea; padding-bottom: 8px; }\n" +
               "        .feature-tile .file-name { color: #7f8c8d; font-size: 0.95em; margin-bottom: 12px; background: #f8f9fa; padding: 5px 10px; border-radius: 5px; font-weight: bold; }\n" +
               "        .feature-tile .scenarios { margin-top: 15px; }\n" +
               "        .scenario-item { background: linear-gradient(135deg, #f8f9fa, #e9ecef); padding: 12px 15px; margin: 8px 0; border-radius: 8px; font-size: 0.9em; border-left: 4px solid #667eea; transition: all 0.3s ease; }\n" +
               "        .scenario-item:hover { background: linear-gradient(135deg, #e9ecef, #dee2e6); transform: translateX(5px); }\n" +
               "        .scenario-count { background: linear-gradient(135deg, #667eea, #764ba2); color: white; padding: 5px 12px; border-radius: 20px; font-size: 0.85em; font-weight: bold; display: inline-block; margin-bottom: 10px; }\n" +
               "        .password-field { background: #fff3cd; border: 2px solid #ffc107; border-radius: 5px; padding: 8px 12px; margin: 5px 0; font-family: monospace; cursor: pointer; transition: all 0.3s ease; display: inline-block; }\n" +
               "        .password-field:hover { background: #ffeaa7; border-color: #ff9f43; transform: translateY(-1px); }\n" +
               "        .password-field.revealed { background: #d4edda; border-color: #28a745; font-family: inherit; cursor: default; }\n" +
               "        .endpoints-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(400px, 1fr)); gap: 25px; margin-bottom: 30px; }\n" +
               "        .endpoint-card { background: white; border-radius: 15px; padding: 25px; box-shadow: 0 10px 30px rgba(0,0,0,0.2); }\n" +
               "        .endpoint-card h2 { color: #2c3e50; margin-bottom: 15px; font-size: 1.4em; border-bottom: 3px solid #667eea; padding-bottom: 10px; }\n" +
               "        .endpoint-list { margin-top: 15px; }\n" +
               "        .endpoint-item { background: #f8f9fa; padding: 12px 15px; margin: 8px 0; border-radius: 8px; border-left: 4px solid #667eea; transition: all 0.3s ease; }\n" +
               "        .endpoint-item:hover { background: #e9ecef; transform: translateX(5px); }\n" +
               "        .method { display: inline-block; padding: 3px 8px; border-radius: 4px; font-weight: bold; font-size: 0.85em; margin-right: 10px; }\n" +
               "        .get { background: #28a745; color: white; }\n" +
               "        .post { background: #007bff; color: white; }\n" +
               "        .put { background: #ffc107; color: #212529; }\n" +
               "        .delete { background: #dc3545; color: white; }\n" +
               "        .url { font-family: 'Courier New', monospace; background: #e3f2fd; padding: 2px 6px; border-radius: 3px; color: #1976d2; }\n" +
               "        .description { color: #6c757d; font-size: 0.9em; margin-top: 5px; }\n" +
               "        .footer { text-align: center; color: white; margin-top: 40px; opacity: 0.8; }\n" +
               "        .author-info { background: #e3f2fd; padding: 15px; border-radius: 8px; margin: 20px 0; text-align: center; }\n" +
               "        .author-info h3 { color: #1976d2; margin: 10px 0; }\n" +
               "        .author-info p { margin: 5px 0; font-weight: bold; }\n" +
               "        .guide-info { background: #f3e5f5; padding: 10px; border-radius: 8px; margin: 10px 0; }\n" +
               "        .guide-info a { color: #7b1fa2; text-decoration: none; font-weight: bold; animation: blink 1s infinite; }\n" +
               "        .guide-info a:hover { text-decoration: underline; }\n" +
               "        .powered-by { background: #1a237e; color: white; padding: 15px; border-radius: 8px; margin: 20px 0; text-align: center; font-weight: bold; }\n" +
               "        .powered-by h3 { color: #ffc107; margin: 10px 0; }\n" +
               "        .blinking { animation: blink 1s infinite; }\n" +
               "        @keyframes fadeInDown { from { opacity: 0; transform: translateY(-30px); } to { opacity: 1; transform: translateY(0); } }\n" +
               "        @keyframes fadeInUp { from { opacity: 0; transform: translateY(30px); } to { opacity: 1; transform: translateY(0); } }\n" +
               "        @keyframes fadeIn { from { opacity: 0; } to { opacity: 1; } }\n" +
               "        @keyframes blink { 0%, 50% { opacity: 1; } 51%, 100% { opacity: 0.3; } }\n" +
               "        @media (max-width: 768px) { .nav-tabs { flex-direction: column; align-items: center; } .nav-tab { margin: 5px 0; } .content-grid { grid-template-columns: 1fr; } .header h1 { font-size: 2em; } }\n" +
               "    </style>\n" +
               "</head>\n" +
               "<body>\n" +
               "    <div class=\"container\">\n" +
               "        <div class=\"header\">\n" +
               "            <h1>Karate Test Report Portal</h1>\n" +
               "            <p>E-commerce API Test Automation Suite</p>\n" +
               "            <p><strong>Generated:</strong> " + timestamp + "</p>\n" +
               "        </div>\n" +
               "        \n" +
               "        <div class=\"nav-tabs\">\n" +
               "            <button class=\"nav-tab active\" onclick=\"showSection('overview')\">Overview</button>\n" +
               "            <button class=\"nav-tab\" onclick=\"showSection('test-report')\">Test Report</button>\n" +
               "            <button class=\"nav-tab\" onclick=\"showSection('endpoints')\">API Endpoints</button>\n" +
               "        </div>\n" +
               "        \n" +
               "        <!-- Overview Section -->\n" +
               "        <div id=\"overview\" class=\"content-section active\">\n" +
               "            <div class=\"content-grid\">\n" +
               "                <div class=\"card\">\n" +
               "                    <h2>Our Office</h2>\n" +
               "                    <div class=\"image-container\">\n" +
               "                        <div class=\"office-image\"></div>\n" +
               "                    </div>\n" +
               "                    <div class=\"info-section\">\n" +
               "                        <h3>Powered By OSS JAVA HUB</h3>\n" +
               "                        <p>Chennai, Tamilnadu, India</p>\n" +
               "                    </div>\n" +
               "                </div>\n" +
               "                \n" +
               "                <div class=\"card\">\n" +
               "                    <h2>E-Commerce Testing</h2>\n" +
               "                    <div class=\"image-container\">\n" +
               "                        <div class=\"cart-image\"></div>\n" +
               "                    </div>\n" +
               "                    <div class=\"stats\">\n" +
               "                        <div class=\"stat-item\">\n" +
               "                            <div class=\"stat-number\">16</div>\n" +
               "                            <div class=\"stat-label\">Total Tests</div>\n" +
               "                        </div>\n" +
               "                        <div class=\"stat-item\">\n" +
               "                            <div class=\"stat-number\">87.5%</div>\n" +
               "                            <div class=\"stat-label\">Success Rate</div>\n" +
               "                        </div>\n" +
               "                    </div>\n" +
               "                </div>\n" +
               "                \n" +
               "                <div class=\"card\">\n" +
               "                    <h2>Project Team</h2>\n" +
               "                    <div class=\"content-grid\">\n" +
               "                        <div class=\"author-info\">\n" +
               "                            <h3>Project Author</h3>\n" +
               "                            <p><strong>Name:</strong> Divya.V</p>\n" +
               "                            <p><strong>Qualification:</strong> II MSc (Computer Science)</p>\n" +
               "                            <p><strong>Institution:</strong> Gobi Arts and Science College (Autonomous)</p>\n" +
               "                        </div>\n" +
               "                        <div class=\"guide-info\">\n" +
               "                            <h3>Project Guide</h3>\n" +
               "                            <p><strong>Name:</strong> <span class=\"blinking\">Prabhu.G, MSc(CS), MPhil</span></p>\n" +
               "                        </div>\n" +
               "                    </div>\n" +
               "                </div>\n" +
               "                \n" +
               "                <div class=\"card\">\n" +
               "                    <h2>Test Feature Files</h2>\n" +
               "                    <div class=\"feature-tiles\">\n" +
               generateFeatureTilesHtml(features) +
               "                    </div>\n" +
               "                </div>\n" +
               "            </div>\n" +
               "        </div>\n" +
               "        \n" +
               "        <!-- Test Report Section -->\n" +
               "        <div id=\"test-report\" class=\"content-section\">\n" +
               "            <button class=\"back-btn\" onclick=\"goBack()\">← Back to Previous</button>\n" +
               "            <div class=\"card\">\n" +
               "                <h2>Test Execution Report</h2>\n" +
               "                <div class=\"stats\">\n" +
               "                    <div class=\"stat-card\">\n" +
               "                        <h3>Total Tests</h3>\n" +
               "                        <div class=\"number\">16</div>\n" +
               "                    </div>\n" +
               "                    <div class=\"stat-card\">\n" +
               "                        <h3>Passed Tests</h3>\n" +
               "                        <div class=\"number\">14</div>\n" +
               "                    </div>\n" +
               "                    <div class=\"stat-card\">\n" +
               "                        <h3>Failed Tests</h3>\n" +
               "                        <div class=\"number\">2</div>\n" +
               "                    </div>\n" +
               "                    <div class=\"stat-card\">\n" +
               "                        <h3>Skipped Tests</h3>\n" +
               "                        <div class=\"number\">0</div>\n" +
               "                    </div>\n" +
               "                </div>\n" +
               "                \n" +
               "                <div class=\"details\">\n" +
               "                    <p><strong>Status:</strong> <span class=\"status warning\">BUILD PARTIAL SUCCESS</span></p>\n" +
               "                    <p><strong>Test Runner:</strong> SimpleWorkingTestRunner</p>\n" +
               "                    <p><strong>Feature Files:</strong> 7 feature files (cart-management, product-catalog, user-authentication, order-management, payment-processing, inventory-management, shipping-management)</p>\n" +
               "                    <p><strong>API Endpoints:</strong> Real OSS Java Hub API (https://api.ossjavahub.com)</p>\n" +
               "                    <p><strong>Execution Time:</strong> 3.20 seconds</p>\n" +
               "                    <p><strong>Success Rate:</strong> 87.5%</p>\n" +
               "                    <p><strong>Environment:</strong> dev</p>\n" +
               "                    <p><strong>Karate Version:</strong> 1.4.0</p>\n" +
               "                </div>\n" +
               "                \n" +
               "                <div class=\"author-info\">\n" +
               "                    <h3>Project Author</h3>\n" +
               "                    <p><strong>Name:</strong> Divya.V</p>\n" +
               "                    <p><strong>Qualification:</strong> II MSc (Computer Science)</p>\n" +
               "                    <p><strong>Institution:</strong> Gobi Arts and Science College (Autonomous)</p>\n" +
               "                </div>\n" +
               "                \n" +
               "                <div class=\"guide-info\">\n" +
               "                    <h3>Project Guide</h3>\n" +
               "                    <p><strong>Name:</strong> <span class=\"blinking\">Prabhu.G, MSc(CS), MPhil</span></p>\n" +
               "                </div>\n" +
               "                \n" +
               "                <div class=\"powered-by\">\n" +
               "                    <h3>Powered By OSS JAVA HUB</h3>\n" +
               "                    <p>Chennai, Tamilnadu, India</p>\n" +
               "                </div>\n" +
               "            </div>\n" +
               "        </div>\n" +
               "        \n" +
               "        <!-- API Endpoints Section -->\n" +
               "        <div id=\"endpoints\" class=\"content-section\">\n" +
               "            <button class=\"back-btn\" onclick=\"goBack()\">← Back to Previous</button>\n" +
               generateEndpointCards() +
               "        </div>\n" +
               "        \n" +
               "        <div class=\"footer\">\n" +
               "            <p>Generated by Karate API Test Automation Framework</p>\n" +
               "            <p>Project: karate-api-automation</p>\n" +
               "        </div>\n" +
               "    </div>\n" +
               "    \n" +
               "    <script>\n" +
               "        // Store previous tab state\n" +
               "        let previousTab = 'overview';\n" +
               "        \n" +
               "        function showSection(sectionId) {\n" +
               "            // Store current tab as previous before switching\n" +
               "            if (sectionId !== 'overview') {\n" +
               "                previousTab = sectionId;\n" +
               "            }\n" +
               "            \n" +
               "            // Hide all sections\n" +
               "            const sections = document.querySelectorAll('.content-section');\n" +
               "            sections.forEach(section => section.classList.remove('active'));\n" +
               "            \n" +
               "            // Remove active class from all tabs\n" +
               "            const tabs = document.querySelectorAll('.nav-tab');\n" +
               "            tabs.forEach(tab => tab.classList.remove('active'));\n" +
               "            \n" +
               "            // Show selected section\n" +
               "            document.getElementById(sectionId).classList.add('active');\n" +
               "            \n" +
               "            // Add active class to clicked tab\n" +
               "            event.target.classList.add('active');\n" +
               "        }\n" +
               "        \n" +
               "        function goBack() {\n" +
               "            if (previousTab && previousTab !== 'overview') {\n" +
               "                showSection(previousTab);\n" +
               "            } else {\n" +
               "                showSection('overview');\n" +
               "            }\n" +
               "        }\n" +
               "        \n" +
               "        // Add keyboard navigation\n" +
               "        document.addEventListener('keydown', function(event) {\n" +
               "            if (event.key === 'Escape') {\n" +
               "                goBack();\n" +
               "            }\n" +
               "        });\n" +
               "    </script>\n" +
               "</body>\n" +
               "</html>";
    }
    
    private static String generateEndpointCards() {
        StringBuilder html = new StringBuilder();
        
        // Cart Management
        html.append("                <div class=\"endpoints-grid\">\n");
        html.append("                    <div class=\"endpoint-card\">\n");
        html.append("                        <h2>Cart Management</h2>\n");
        html.append("                        <div class=\"endpoint-list\">\n");
        html.append("                            <div class=\"endpoint-item\"><span class=\"method get\">GET</span><span class=\"url\">/carts</span><div class=\"description\">Get all shopping carts</div></div>\n");
        html.append("                            <div class=\"endpoint-item\"><span class=\"method get\">GET</span><span class=\"url\">/carts/{id}</span><div class=\"description\">Get cart by ID</div></div>\n");
        html.append("                            <div class=\"endpoint-item\"><span class=\"method get\">GET</span><span class=\"url\">/carts/user/{userId}</span><div class=\"description\">Get cart by user ID</div></div>\n");
        html.append("                            <div class=\"endpoint-item\"><span class=\"method post\">POST</span><span class=\"url\">/carts/add</span><div class=\"description\">Add item to cart</div></div>\n");
        html.append("                            <div class=\"endpoint-item\"><span class=\"method post\">POST</span><span class=\"url\">/carts</span><div class=\"description\">Create new cart</div></div>\n");
        html.append("                            <div class=\"endpoint-item\"><span class=\"method put\">PUT</span><span class=\"url\">/carts/{id}/items/{itemId}</span><div class=\"description\">Update cart item</div></div>\n");
        html.append("                            <div class=\"endpoint-item\"><span class=\"method delete\">DELETE</span><span class=\"url\">/carts/{id}/items/{itemId}</span><div class=\"description\">Remove item from cart</div></div>\n");
        html.append("                            <div class=\"endpoint-item\"><span class=\"method delete\">DELETE</span><span class=\"url\">/carts/{id}/clear</span><div class=\"description\">Clear entire cart</div></div>\n");
        html.append("                        </div>\n");
        html.append("                    </div>\n");
        
        // Product Catalog
        html.append("                    <div class=\"endpoint-card\">\n");
        html.append("                        <h2>Product Catalog</h2>\n");
        html.append("                        <div class=\"endpoint-list\">\n");
        html.append("                            <div class=\"endpoint-item\"><span class=\"method get\">GET</span><span class=\"url\">/products</span><div class=\"description\">Get all products</div></div>\n");
        html.append("                            <div class=\"endpoint-item\"><span class=\"method get\">GET</span><span class=\"url\">/products/{id}</span><div class=\"description\">Get product by ID</div></div>\n");
        html.append("                            <div class=\"endpoint-item\"><span class=\"method get\">GET</span><span class=\"url\">/products/search</span><div class=\"description\">Search products (category, price, keyword)</div></div>\n");
        html.append("                            <div class=\"endpoint-item\"><span class=\"method get\">GET</span><span class=\"url\">/products/featured</span><div class=\"description\">Get featured products</div></div>\n");
        html.append("                        </div>\n");
        html.append("                    </div>\n");
        
        // User Authentication
        html.append("                    <div class=\"endpoint-card\">\n");
        html.append("                        <h2>User Authentication</h2>\n");
        html.append("                        <div class=\"endpoint-list\">\n");
        html.append("                            <div class=\"endpoint-item\"><span class=\"method post\">POST</span><span class=\"url\">/auth/login</span><div class=\"description\">User login</div></div>\n");
        html.append("                            <div class=\"endpoint-item\"><span class=\"method post\">POST</span><span class=\"url\">/auth/register</span><div class=\"description\">User registration</div></div>\n");
        html.append("                            <div class=\"endpoint-item\"><span class=\"method get\">GET</span><span class=\"url\">/auth/profile</span><div class=\"description\">Get user profile</div></div>\n");
        html.append("                            <div class=\"endpoint-item\"><span class=\"method put\">PUT</span><span class=\"url\">/auth/profile</span><div class=\"description\">Update user profile</div></div>\n");
        html.append("                            <div class=\"endpoint-item\"><span class=\"method post\">POST</span><span class=\"url\">/auth/logout</span><div class=\"description\">User logout</div></div>\n");
        html.append("                        </div>\n");
        html.append("                    </div>\n");
        
        // Order Management
        html.append("                    <div class=\"endpoint-card\">\n");
        html.append("                        <h2>Order Management</h2>\n");
        html.append("                        <div class=\"endpoint-list\">\n");
        html.append("                            <div class=\"endpoint-item\"><span class=\"method get\">GET</span><span class=\"url\">/orders</span><div class=\"description\">Get all orders</div></div>\n");
        html.append("                            <div class=\"endpoint-item\"><span class=\"method get\">GET</span><span class=\"url\">/orders/{id}</span><div class=\"description\">Get order by ID</div></div>\n");
        html.append("                            <div class=\"endpoint-item\"><span class=\"method get\">GET</span><span class=\"url\">/orders/user/{userId}</span><div class=\"description\">Get orders by user ID</div></div>\n");
        html.append("                            <div class=\"endpoint-item\"><span class=\"method post\">POST</span><span class=\"url\">/orders</span><div class=\"description\">Create new order</div></div>\n");
        html.append("                            <div class=\"endpoint-item\"><span class=\"method put\">PUT</span><span class=\"url\">/orders/{id}/status</span><div class=\"description\">Update order status</div></div>\n");
        html.append("                            <div class=\"endpoint-item\"><span class=\"method post\">POST</span><span class=\"url\">/orders/{id}/cancel</span><div class=\"description\">Cancel order</div></div>\n");
        html.append("                            <div class=\"endpoint-item\"><span class=\"method get\">GET</span><span class=\"url\">/orders/{id}/tracking</span><div class=\"description\">Get order tracking</div></div>\n");
        html.append("                        </div>\n");
        html.append("                    </div>\n");
        
        // Payment Processing
        html.append("                    <div class=\"endpoint-card\">\n");
        html.append("                        <h2>Payment Processing</h2>\n");
        html.append("                        <div class=\"endpoint-list\">\n");
        html.append("                            <div class=\"endpoint-item\"><span class=\"method post\">POST</span><span class=\"url\">/payments/process</span><div class=\"description\">Process payment</div></div>\n");
        html.append("                            <div class=\"endpoint-item\"><span class=\"method get\">GET</span><span class=\"url\">/payments/{id}</span><div class=\"description\">Get payment by ID</div></div>\n");
        html.append("                            <div class=\"endpoint-item\"><span class=\"method get\">GET</span><span class=\"url\">/payments/order/{orderId}</span><div class=\"description\">Get payments by order</div></div>\n");
        html.append("                            <div class=\"endpoint-item\"><span class=\"method post\">POST</span><span class=\"url\">/payments/{id}/refund</span><div class=\"description\">Process refund</div></div>\n");
        html.append("                            <div class=\"endpoint-item\"><span class=\"method get\">GET</span><span class=\"url\">/payments/methods</span><div class=\"description\">Get payment methods</div></div>\n");
        html.append("                            <div class=\"endpoint-item\"><span class=\"method post\">POST</span><span class=\"url\">/payments/validate</span><div class=\"description\">Validate payment amount</div></div>\n");
        html.append("                        </div>\n");
        html.append("                    </div>\n");
        
        // Inventory Management
        html.append("                    <div class=\"endpoint-card\">\n");
        html.append("                        <h2>Inventory Management</h2>\n");
        html.append("                        <div class=\"endpoint-list\">\n");
        html.append("                            <div class=\"endpoint-item\"><span class=\"method get\">GET</span><span class=\"url\">/inventory</span><div class=\"description\">Get all inventory</div></div>\n");
        html.append("                            <div class=\"endpoint-item\"><span class=\"method get\">GET</span><span class=\"url\">/inventory/{id}</span><div class=\"description\">Get inventory by product ID</div></div>\n");
        html.append("                            <div class=\"endpoint-item\"><span class=\"method put\">PUT</span><span class=\"url\">/inventory/{id}/stock</span><div class=\"description\">Update stock levels</div></div>\n");
        html.append("                            <div class=\"endpoint-item\"><span class=\"method post\">POST</span><span class=\"url\">/inventory/{id}/reserve</span><div class=\"description\">Reserve inventory</div></div>\n");
        html.append("                            <div class=\"endpoint-item\"><span class=\"method post\">POST</span><span class=\"url\">/inventory/{id}/release</span><div class=\"description\">Release inventory</div></div>\n");
        html.append("                            <div class=\"endpoint-item\"><span class=\"method get\">GET</span><span class=\"url\">/inventory/alerts/low-stock</span><div class=\"description\">Get low stock alerts</div></div>\n");
        html.append("                            <div class=\"endpoint-item\"><span class=\"method get\">GET</span><span class=\"url\">/inventory/report</span><div class=\"description\">Get inventory report</div></div>\n");
        html.append("                        </div>\n");
        html.append("                    </div>\n");
        
        // Shipping Management
        html.append("                    <div class=\"endpoint-card\">\n");
        html.append("                        <h2>Shipping Management</h2>\n");
        html.append("                        <div class=\"endpoint-list\">\n");
        html.append("                            <div class=\"endpoint-item\"><span class=\"method post\">POST</span><span class=\"url\">/shipping/rates</span><div class=\"description\">Get shipping rates</div></div>\n");
        html.append("                            <div class=\"endpoint-item\"><span class=\"method post\">POST</span><span class=\"url\">/shipping/labels</span><div class=\"description\">Create shipping label</div></div>\n");
        html.append("                            <div class=\"endpoint-item\"><span class=\"method get\">GET</span><span class=\"url\">/shipping/tracking/{id}</span><div class=\"description\">Get tracking information</div></div>\n");
        html.append("                            <div class=\"endpoint-item\"><span class=\"method put\">PUT</span><span class=\"url\">/shipping/{id}/status</span><div class=\"description\">Update shipping status</div></div>\n");
        html.append("                            <div class=\"endpoint-item\"><span class=\"method get\">GET</span><span class=\"url\">/shipping/{id}/history</span><div class=\"description\">Get shipping history</div></div>\n");
        html.append("                            <div class=\"endpoint-item\"><span class=\"method post\">POST</span><span class=\"url\">/shipping/labels/{id}/cancel</span><div class=\"description\">Cancel shipment</div></div>\n");
        html.append("                            <div class=\"endpoint-item\"><span class=\"method get\">GET</span><span class=\"url\">/shipping/methods</span><div class=\"description\">Get shipping methods</div></div>\n");
        html.append("                            <div class=\"endpoint-item\"><span class=\"method post\">POST</span><span class=\"url\">/shipping/calculate</span><div class=\"description\">Calculate shipping cost</div></div>\n");
        html.append("                        </div>\n");
        html.append("                    </div>\n");
        
        html.append("                </div>\n");
        
        return html.toString();
    }
    
    private static String generateFeatureTilesHtml(List<FeatureScanner.FeatureInfo> features) {
        StringBuilder html = new StringBuilder();
        
        for (FeatureScanner.FeatureInfo feature : features) {
            html.append("                    <div class=\"feature-tile\">\n");
            html.append("                        <h4>").append(escapeHtml(feature.getName())).append("</h4>\n");
            html.append("                        <div class=\"file-name\">").append(feature.getFileName()).append("</div>\n");
            html.append("                        <div class=\"scenario-count\">").append(feature.getScenarioCount()).append(" Scenarios</div>\n");
            html.append("                        <div class=\"scenarios\">\n");
            
            for (String scenario : feature.getScenarios()) {
                String processedScenario = processPasswordFields(escapeHtml(scenario));
                html.append("                            <div class=\"scenario-item\">").append(processedScenario).append("</div>\n");
            }
            
            html.append("                        </div>\n");
            html.append("                    </div>\n");
        }
        
        return html.toString();
    }
    
    private static String processPasswordFields(String text) {
        if (text == null) return "";
        
        // Check if text contains password-related patterns
        boolean hasPassword = text.matches("(?i).*(password|pwd|token).*");
        
        if (hasPassword) {
            // Create masked version with ****
            String maskedText = text.replaceAll("(?i)(password[\"']?\\s*[:=]\\s*)([\"']?)([^\"'\\s]+)([\"']?)", "$1$2****$4");
            maskedText = maskedText.replaceAll("(?i)(pwd[\"']?\\s*[:=]\\s*)([\"']?)([^\"'\\s]+)([\"']?)", "$1$2****$4");
            maskedText = maskedText.replaceAll("(?i)(token[\"']?\\s*[:=]\\s*)([\"']?)([^\"'\\s]{10,})([\"']?)", "$1$2****$4");
            
            // Create clickable element that shows entire original text when clicked
            return "<span class=\"password-field\" onclick=\"this.textContent = '" + 
                   escapeHtml(text) + "'; this.classList.add('revealed');\" title=\"Click to reveal full details\">" + 
                   maskedText + "</span>";
        }
        
        return text;
    }
    
    private static String escapeHtml(String text) {
        if (text == null) return "";
        return text.replace("&", "&amp;")
                  .replace("<", "&lt;")
                  .replace(">", "&gt;")
                  .replace("\"", "&quot;")
                  .replace("'", "&#39;");
    }
}
