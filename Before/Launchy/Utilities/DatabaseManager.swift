//
//  DatabaseManager.swift
//  Launchy
//
//  Created by Jacob Bartlett on 29/08/2025.
//

import Foundation
import CoreData

class DatabaseManager {
    static let shared = DatabaseManager()
    
    private var isSchemaInitialized = false
    private var managedObjectContext: NSManagedObjectContext?
    
    private init() {}
    
    func initializeSchema() {
        print("🗄️ DatabaseManager: Initializing Core Data schema...")
        
        // Simulate Core Data stack setup
        Thread.sleep(forTimeInterval: 0.1)
        
        // Mark as initialized
        isSchemaInitialized = true
        print("🗄️ DatabaseManager: Schema initialization complete")
    }
    
    func requireSchemaInitialized() {
        guard isSchemaInitialized else {
            print("💥 CRITICAL DATABASE ERROR!")
            print("   Attempted to use database before schema was initialized.")
            print("   This is a common real-world crash when launch order is wrong!")
            print("   DatabaseSchema step must complete before Persistence step.")
            
            fatalError("❌ Database schema not initialized! This demonstrates why proper launch step ordering is critical in production apps.")
        }
        
        print("✅ Database schema check passed - ready for persistence operations")
    }
}
