//
//  PersistenceStep.swift
//  Launchy
//
//  Created by Jacob Bartlett on 29/08/2025.
//

import Foundation

class PersistenceStep: LaunchStep {
    let name = "Persistence"
    let dependencies: [LaunchStep.Type] = [AppConfigStep.self, DatabaseSchemaStep.self]
    let priority = LaunchPriority.critical

    func execute() {
        Thread.sleep(forTimeInterval: 0.4) // 400ms - one of the longest steps
        
        // Critical dependency check - will crash if DatabaseSchema hasn't completed
        DatabaseManager.shared.requireSchemaInitialized()
        
        // Simulate set up repository pattern, initialize DAOs
        print("Setting up persistence layer...")
        Thread.sleep(forTimeInterval: 0.1)
        
        // Simulate create database connections, warm up frequently accessed queries
        print("Establishing database connections...")
        Thread.sleep(forTimeInterval: 0.15)
        
        // Simulate preload reference data into memory
        print("Preloading reference data...")
        Thread.sleep(forTimeInterval: 0.1)
        
        // Simulate warming up frequently accessed queries
        print("Warming up query cache...")
        Thread.sleep(forTimeInterval: 0.05)
        
        print("✓ Persistence initialized")
    }
}
