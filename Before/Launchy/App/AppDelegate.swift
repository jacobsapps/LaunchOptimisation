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
        
        // Execute all launch steps synchronously on main thread
        // This blocks the UI and creates the performance bottleneck we want to demonstrate
        LaunchOrchestrator.shared.executeAllStepsBlocking()
        
        let totalTime = CFAbsoluteTimeGetCurrent() - startTime
        print("⏱ Total launch time: \(String(format: "%.2f", totalTime))s")
        
        // Print profiling report
        LaunchTimeProfiler.shared.printReport()
        
        // Identify bottlenecks for optimization opportunities
        let bottlenecks = LaunchTimeProfiler.shared.identifyBottlenecks(threshold: 0.1)
        if !bottlenecks.isEmpty {
            print("\n🔍 Optimization opportunities (>100ms):")
            for bottleneck in bottlenecks {
                print("  • \(bottleneck)")
            }
        }
        
        return true
    }
}
