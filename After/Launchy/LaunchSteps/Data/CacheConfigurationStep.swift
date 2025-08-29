//
//  CacheConfigurationStep.swift
//  Launchy
//
//  Created by Jacob Bartlett on 29/08/2025.
//

import Foundation

class CacheConfigurationStep: LaunchStep {
    let name = "CacheConfiguration"
    let dependencies = ["Persistence"]
    let priority = LaunchPriority.medium
    let isBlocking = true
    
    func execute() {
        Thread.sleep(forTimeInterval: 0.06) // 60ms
        
        // Configure NSCache limits, set up disk cache with size limits
        let memoryCache = NSCache<NSString, AnyObject>()
        memoryCache.countLimit = 100
        memoryCache.totalCostLimit = 50 * 1024 * 1024 // 50MB
        
        // Simulate initialize image cache (SDWebImage/Kingfisher)
        print("Configuring image cache with 50MB limit")
        Thread.sleep(forTimeInterval: 0.02)
        
        // Simulate clear expired cache entries
        print("Clearing expired cache entries...")
        Thread.sleep(forTimeInterval: 0.01)
        
        print("✓ Cache Configuration initialized")
    }
}
