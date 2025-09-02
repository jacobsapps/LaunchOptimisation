//
//  NonCriticalFeaturesStep.swift
//  Launchy
//
//  Created by Jacob Bartlett on 29/08/2025.
//

import Foundation

class NonCriticalFeaturesStep: LaunchStep {
    let name = "NonCriticalFeatures"
    let dependencies: [LaunchStep.Type] = [CriticalFeaturesStep.self, AnalyticsStep.self]
    let priority = LaunchPriority.low

    func execute() {
        Thread.sleep(forTimeInterval: 0.2) // 200ms
        
        // Simulate set up secondary features like tooltips, onboarding flows
        print("Initializing non-critical features...")
        
        // Simulate tooltips system
        Thread.sleep(forTimeInterval: 0.05)
        print("  - Tooltips and hints system")
        
        // Simulate onboarding flows
        Thread.sleep(forTimeInterval: 0.04)
        print("  - Onboarding flow components")
        
        // Simulate premium features
        Thread.sleep(forTimeInterval: 0.03)
        print("  - Premium feature gates")
        
        // Simulate social sharing
        Thread.sleep(forTimeInterval: 0.03)
        print("  - Social sharing integration")
        
        // Simulate review prompts, easter eggs
        Thread.sleep(forTimeInterval: 0.02)
        print("  - Review prompts and easter eggs")
        
        print("✓ Non-Critical Features initialized")
    }
}
