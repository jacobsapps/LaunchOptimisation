//
//  AppConfigStep.swift
//  Launchy
//
//  Created by Jacob Bartlett on 29/08/2025.
//

import Foundation

class AppConfigStep: LaunchStep {
    let name = "AppConfig"
    let dependencies: [String] = []
    let priority = LaunchPriority.critical
    let isBlocking = true
    
    func execute() {
        Thread.sleep(forTimeInterval: 0.05) // 50ms
        
        // Simulate reading Bundle.main plist/JSON files, parse environment configuration
        if let path = Bundle.main.path(forResource: "Info", ofType: "plist") {
            _ = NSDictionary(contentsOfFile: path)
        }
        
        print("✓ App Config initialized")
    }
}
