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
        
        // Execute all app setup launch steps
        LaunchOrchestrator.shared.executeLaunchSteps()
        
        let totalTime = CFAbsoluteTimeGetCurrent() - startTime
        print("⏱ Total launch time: \(String(format: "%.2f", totalTime))s")
        
        // Print profiling report
        LaunchTimeProfiler.shared.printReport()
        
        return true
    }
}
