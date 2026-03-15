package com.ecommerce.karate;

import java.io.FileWriter;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

/**
 * Landing Page Generator for Karate Test Reports
 * Creates a professional landing page with images and report link
 */
public class LandingPageGenerator {
    
    public static void main(String[] args) {
        generateLandingPage();
    }
    
    public static void generateLandingPage() {
        try {
            // Create target directory if it doesn't exist
            Files.createDirectories(Paths.get("target"));
            Files.createDirectories(Paths.get("target/images"));
            
            // Copy images to target directory
            copyImages();
            
            String htmlContent = generateLandingPageContent();
            
            try (FileWriter writer = new FileWriter("target/index.html")) {
                writer.write(htmlContent);
            }
            
            System.out.println("Landing Page generated successfully: target/index.html");
            
        } catch (IOException e) {
            System.err.println("Error generating landing page: " + e.getMessage());
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
    
    private static String generateLandingPageContent() {
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
               "    <title>Karate Test Report Portal</title>\n" +
               "    <style>\n" +
               "        * { margin: 0; padding: 0; box-sizing: border-box; }\n" +
               "        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); min-height: 100vh; }\n" +
               "        .container { max-width: 1200px; margin: 0 auto; padding: 20px; }\n" +
               "        .header { text-align: center; color: white; margin-bottom: 40px; animation: fadeInDown 1s ease; }\n" +
               "        .header h1 { font-size: 3em; margin-bottom: 10px; text-shadow: 2px 2px 4px rgba(0,0,0,0.3); }\n" +
               "        .header p { font-size: 1.2em; opacity: 0.9; }\n" +
               "        .content-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 30px; margin-bottom: 40px; }\n" +
               "        .card { background: white; border-radius: 15px; padding: 30px; box-shadow: 0 10px 30px rgba(0,0,0,0.2); animation: fadeInUp 1s ease; }\n" +
               "        .card h2 { color: #2c3e50; margin-bottom: 20px; font-size: 1.8em; }\n" +
               "        .image-container { text-align: center; margin: 20px 0; }\n" +
               "        .office-image { width: 100%; max-width: 400px; height: 250px; background: url('images/office.jpg') center/cover; border-radius: 10px; margin: 0 auto; }\n" +
               "        .cart-image { width: 100%; max-width: 300px; height: 200px; background: url('images/shopping-cart.jpg') center/cover; border-radius: 10px; margin: 0 auto; }\n" +
               "        .info-section { background: rgba(255,255,255,0.1); padding: 20px; border-radius: 10px; margin: 20px 0; color: white; }\n" +
               "        .info-section h3 { color: #ffc107; margin-bottom: 10px; }\n" +
               "        .info-section p { margin: 5px 0; font-weight: bold; }\n" +
               "        .cta-section { text-align: center; margin: 40px 0; }\n" +
               "        .view-report-btn { background: linear-gradient(45deg, #ff6b6b, #ee5a24); color: white; padding: 15px 40px; border: none; border-radius: 50px; font-size: 1.2em; font-weight: bold; cursor: pointer; transition: all 0.3s ease; box-shadow: 0 4px 15px rgba(238,90,36,0.4); animation: pulse 2s infinite; }\n" +
               "        .view-report-btn:hover { transform: translateY(-2px); box-shadow: 0 6px 20px rgba(238,90,36,0.6); }\n" +
               "        .stats-preview { display: flex; justify-content: space-around; background: white; padding: 20px; border-radius: 10px; margin: 20px 0; }\n" +
               "        .stat-item { text-align: center; }\n" +
               "        .stat-number { font-size: 2em; font-weight: bold; color: #667eea; }\n" +
               "        .stat-label { color: #7f8c8d; margin-top: 5px; }\n" +
               "        .footer { text-align: center; color: white; margin-top: 40px; opacity: 0.8; }\n" +
               "        .feature-tiles { display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 20px; margin: 20px 0; }\n" +
               "        .feature-tile { background: white; border-radius: 10px; padding: 20px; box-shadow: 0 4px 15px rgba(0,0,0,0.1); transition: transform 0.3s ease; }\n" +
               "        .feature-tile:hover { transform: translateY(-5px); box-shadow: 0 8px 25px rgba(0,0,0,0.15); }\n" +
               "        .feature-tile h4 { color: #2c3e50; margin-bottom: 10px; font-size: 1.1em; }\n" +
               "        .feature-tile .file-name { color: #7f8c8d; font-size: 0.9em; margin-bottom: 10px; }\n" +
               "        .feature-tile .scenarios { margin-top: 10px; }\n" +
               "        .scenario-item { background: #f8f9fa; padding: 8px 12px; margin: 5px 0; border-radius: 5px; font-size: 0.9em; border-left: 3px solid #667eea; }\n" +
               "        .scenario-count { background: #667eea; color: white; padding: 2px 8px; border-radius: 12px; font-size: 0.8em; font-weight: bold; }\n" +
               "        .blinking { animation: blink 1s infinite; }\n" +
               "        @keyframes fadeInDown { from { opacity: 0; transform: translateY(-30px); } to { opacity: 1; transform: translateY(0); } }\n" +
               "        @keyframes fadeInUp { from { opacity: 0; transform: translateY(30px); } to { opacity: 1; transform: translateY(0); } }\n" +
               "        @keyframes pulse { 0%, 100% { transform: scale(1); } 50% { transform: scale(1.05); } }\n" +
               "        @keyframes blink { 0%, 50% { opacity: 1; } 51%, 100% { opacity: 0.3; } }\n" +
               "        @media (max-width: 768px) { .content-grid { grid-template-columns: 1fr; } .header h1 { font-size: 2em; } }\n" +
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
               "        <div class=\"content-grid\">\n" +
               "            <div class=\"card\">\n" +
               "                <h2>Our Office</h2>\n" +
               "                <div class=\"image-container\">\n" +
               "                    <div class=\"office-image\"></div>\n" +
               "                </div>\n" +
               "                <div class=\"info-section\">\n" +
               "                    <h3>Powered By OSS JAVA HUB</h3>\n" +
               "                    <p>Chennai, Tamilnadu, India</p>\n" +
               "                </div>\n" +
               "            </div>\n" +
               "            \n" +
               "            <div class=\"card\">\n" +
               "                <h2>E-Commerce Testing</h2>\n" +
               "                <div class=\"image-container\">\n" +
               "                    <div class=\"cart-image\"></div>\n" +
               "                </div>\n" +
               "                <div class=\"stats-preview\">\n" +
               "                    <div class=\"stat-item\">\n" +
               "                        <div class=\"stat-number\">16</div>\n" +
               "                        <div class=\"stat-label\">Total Tests</div>\n" +
               "                    </div>\n" +
               "                    <div class=\"stat-item\">\n" +
               "                        <div class=\"stat-number\">87.5%</div>\n" +
               "                        <div class=\"stat-label\">Success Rate</div>\n" +
               "                    </div>\n" +
               "                </div>\n" +
               "            </div>\n" +
               "        </div>\n" +
               "        \n" +
               "        <div class=\"card\">\n" +
               "            <h2>Project Team</h2>\n" +
               "            <div class=\"content-grid\">\n" +
               "                <div class=\"info-section\">\n" +
               "                    <h3>👨‍💻 Project Author</h3>\n" +
               "                    <p><strong>Name:</strong> Divya.V</p>\n" +
               "                    <p><strong>Qualification:</strong> II MSc (Computer Science)</p>\n" +
               "                    <p><strong>Institution:</strong> Gobi Arts and Science College (Autonomous)</p>\n" +
               "                </div>\n" +
               "                <div class=\"info-section\">\n" +
               "                    <h3>👨‍🏫 Project Guide</h3>\n" +
               "                    <p><strong>Name:</strong> <span class=\"blinking\">Prabhu.G, MSc(CS), MPhil</span></p>\n" +
               "                </div>\n" +
               "            </div>\n" +
               "        </div>\n" +
               "        \n" +
               "        <div class=\"card\">\n" +
               "            <h2>Test Feature Files</h2>\n" +
               "            <div class=\"feature-tiles\">\n" +
               featureTilesHtml +
               "            </div>\n" +
               "        </div>\n" +
               "        \n" +
               "        <div class=\"cta-section\">\n" +
               "            <button class=\"view-report-btn\" onclick=\"window.open('karate-summary.html', '_blank')\">\n" +
               "                📊 View Full Test Report\n" +
               "            </button>\n" +
               "        </div>\n" +
               "        \n" +
               "        <div class=\"footer\">\n" +
               "            <p>🚀 Generated by Karate API Test Automation Framework</p>\n" +
               "            <p>📁 Project: karate-api-automation</p>\n" +
               "        </div>\n" +
               "    </div>\n" +
               "</body>\n" +
               "</html>";
    }
    
    private static String generateFeatureTilesHtml(List<FeatureScanner.FeatureInfo> features) {
        StringBuilder html = new StringBuilder();
        
        for (FeatureScanner.FeatureInfo feature : features) {
            html.append("                <div class=\"feature-tile\">\n");
            html.append("                    <h4>").append(escapeHtml(feature.getName())).append("</h4>\n");
            html.append("                    <div class=\"file-name\">").append(feature.getFileName()).append("</div>\n");
            html.append("                    <div class=\"scenario-count\">").append(feature.getScenarioCount()).append(" Scenarios</div>\n");
            html.append("                    <div class=\"scenarios\">\n");
            
            for (String scenario : feature.getScenarios()) {
                html.append("                        <div class=\"scenario-item\">").append(escapeHtml(scenario)).append("</div>\n");
            }
            
            html.append("                    </div>\n");
            html.append("                </div>\n");
        }
        
        return html.toString();
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
