//
//  AppDelegate.swift
//  Launchy
//
//  Created by Jacob Bartlett on 28/01/2025.
//

import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        // Start launch time profiling
        LaunchTimeProfiler.shared.startProfiling()
        
        let startTime = CFAbsoluteTimeGetCurrent()
        print("🚀 Starting Launchy launch sequence...")
        
        // Create semaphore to block main thread during parallel execution
        let semaphore = DispatchSemaphore(value: 0)
        
        Task.detached(priority: .high) {
            await LaunchOrchestrator.shared.executeCriticalLaunchPath()
            semaphore.signal()
        }
        
        // Block main thread until parallel execution completes
        semaphore.wait()
        
        let totalTime = CFAbsoluteTimeGetCurrent() - startTime
        print("⏱ Total launch time: \(String(format: "%.2f", totalTime))s")
        
        // Print profiling report
        LaunchTimeProfiler.shared.printReport()
        
        // Run non-critical work off the main thread 
        DispatchQueue.global(qos: .utility).async {
            LaunchOrchestrator.shared.executeBackgroundLaunchPath()
        }
        
        return true
    }
}
