//
//  DIContainerStep.swift
//  Launchy
//
//  Created by Jacob Bartlett on 29/08/2025.
//

import Foundation
import Factory

class DIContainerStep: LaunchStep {
    let name = "DIContainer"
    
    func execute() {
        Thread.sleep(forTimeInterval: 0.12) // 120ms
        
        // Simulate build Factory dependency graph, register all services
        print("Building dependency injection container...")
        
        // Simulate register services and repositories
        Thread.sleep(forTimeInterval: 0.05)
        
        // Simulate create singleton instances, validate dependency resolution
        Thread.sleep(forTimeInterval: 0.03)
        
        print("DI container built with Factory framework")
        
        print("✓ DI Container initialized")
    }
}
