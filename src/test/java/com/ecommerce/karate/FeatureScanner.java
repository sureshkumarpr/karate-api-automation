package com.ecommerce.karate;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Scans all feature files and extracts test scenario information
 */
public class FeatureScanner {
    
    public static List<FeatureInfo> scanAllFeatures() {
        List<FeatureInfo> features = new ArrayList<>();
        
        try {
            // Scan all .feature files in the features directory
            Files.walk(Paths.get("src/test/java/features"))
                .filter(path -> path.toString().endsWith(".feature"))
                .forEach(path -> {
                    try {
                        FeatureInfo feature = parseFeatureFile(path);
                        if (feature != null) {
                            features.add(feature);
                        }
                    } catch (IOException e) {
                        System.err.println("Error reading feature file: " + path);
                    }
                });
        } catch (IOException e) {
            System.err.println("Error scanning feature files: " + e.getMessage());
        }
        
        return features;
    }
    
    private static FeatureInfo parseFeatureFile(java.nio.file.Path path) throws IOException {
        List<String> lines = Files.readAllLines(path);
        FeatureInfo feature = new FeatureInfo();
        
        String fileName = path.getFileName().toString();
        feature.setFileName(fileName);
        feature.setPath(path.toString());
        
        boolean inScenario = false;
        StringBuilder scenarioDescription = new StringBuilder();
        
        for (String line : lines) {
            line = line.trim();
            
            // Extract Feature name
            if (line.startsWith("Feature:")) {
                feature.setName(line.substring("Feature:".length()).trim());
            }
            
            // Extract Scenario
            if (line.startsWith("Scenario:")) {
                if (inScenario && scenarioDescription.length() > 0) {
                    feature.addScenario(scenarioDescription.toString());
                }
                scenarioDescription = new StringBuilder();
                scenarioDescription.append(line.substring("Scenario:".length()).trim());
                inScenario = true;
            } else if (line.startsWith("Scenario Outline:")) {
                if (inScenario && scenarioDescription.length() > 0) {
                    feature.addScenario(scenarioDescription.toString());
                }
                scenarioDescription = new StringBuilder();
                scenarioDescription.append(line.substring("Scenario Outline:".length()).trim());
                scenarioDescription.append(" (Data Driven)");
                inScenario = true;
            } else if (inScenario && !line.isEmpty() && !line.startsWith("#") && 
                      !line.startsWith("Given") && !line.startsWith("When") && 
                      !line.startsWith("Then") && !line.startsWith("And") &&
                      !line.startsWith("*") && !line.startsWith("Background:")) {
                // Add additional description lines
                scenarioDescription.append(" - ").append(line);
            }
        }
        
        // Add the last scenario
        if (inScenario && scenarioDescription.length() > 0) {
            feature.addScenario(scenarioDescription.toString());
        }
        
        return feature;
    }
    
    public static class FeatureInfo {
        private String name;
        private String fileName;
        private String path;
        private List<String> scenarios = new ArrayList<>();
        
        // Getters and setters
        public String getName() { return name; }
        public void setName(String name) { this.name = name; }
        public String getFileName() { return fileName; }
        public void setFileName(String fileName) { this.fileName = fileName; }
        public String getPath() { return path; }
        public void setPath(String path) { this.path = path; }
        public List<String> getScenarios() { return scenarios; }
        public void addScenario(String scenario) { this.scenarios.add(scenario); }
        public int getScenarioCount() { return scenarios.size(); }
    }
}
