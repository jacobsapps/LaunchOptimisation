//
//  UserDefaultsStep.swift
//  Launchy
//
//  Created by Jacob Bartlett on 29/08/2025.
//

import Foundation

class UserDefaultsStep: LaunchStep {
    let name = "UserDefaults"
    let dependencies: [LaunchStep.Type] = []
    let priority = LaunchPriority.medium

    func execute() {
        Thread.sleep(forTimeInterval: 0.01) // 10ms
        
        // Simulate synchronize UserDefaults.standard, migrate old preference keys
        UserDefaults.standard.synchronize()
        
        // Simulate setting up default values
        let defaults: [String: Any] = [
            "isFirstLaunch": false,
            "launchCount": UserDefaults.standard.integer(forKey: "launchCount") + 1
        ]
        
        UserDefaults.standard.register(defaults: defaults)
        
        print("✓ User Defaults initialized")
    }
}
