//
//  DatabaseSchemaStep.swift
//  Launchy
//
//  Created by Jacob Bartlett on 29/08/2025.
//

import Foundation
import CoreData

class DatabaseSchemaStep: LaunchStep {
    let name = "DatabaseSchema"
    
    func execute() {
        Thread.sleep(forTimeInterval: 0.3) // 300ms
        
        // Simulate initialize Core Data stack, load NSManagedObjectModel
        // Initialize the database schema through our manager
        DatabaseManager.shared.initializeSchema()
        
        guard let modelURL = Bundle.main.url(forResource: "DataModel", withExtension: "momd") else {
            print("Creating mock Core Data model...")
            Thread.sleep(forTimeInterval: 0.1)
            print("✓ Database Schema initialized (mock)")
            return
        }
        
        // If model exists, simulate loading it
        let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL)
        print("Core Data model loaded: \(managedObjectModel != nil)")
        
        // Simulate create persistent store coordinator, perform lightweight migration
        Thread.sleep(forTimeInterval: 0.1)
        
        print("✓ Database Schema initialized")
    }
}
