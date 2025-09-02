//
//  LaunchTimeProfiler.swift
//  Launchy
//
//  Created by Jacob Bartlett on 29/08/2025.
//

import Foundation
import Synchronization

class LaunchTimeProfiler {
    static let shared = LaunchTimeProfiler()
    
    private let stepTimes = Mutex<[String: TimeInterval]>([:])
    private var startTime: CFAbsoluteTime = 0
    
    private init() {}
    
    func startProfiling() {
        startTime = CFAbsoluteTimeGetCurrent()
        stepTimes.withLock { times in
            times.removeAll()
        }
    }
    
    func recordStepTime(_ stepName: String, duration: TimeInterval) {
        stepTimes.withLock { times in
            times[stepName] = duration
        }
    }
    
    func getTotalLaunchTime() -> TimeInterval {
        return CFAbsoluteTimeGetCurrent() - startTime
    }
    
    func generateReport() -> String {
        var report = "📊 Launch Time Profiling Report\n"
        report += String(repeating: "=", count: 40) + "\n"
        
        let totalTime = getTotalLaunchTime()
        report += String(format: "Total Launch Time: %.2f seconds\n\n", totalTime)
        
        report += "Step-by-step breakdown:\n"
        
        let sortedSteps = stepTimes.withLock { times in
            return times.sorted { $0.value > $1.value }
        }
        
        for (stepName, duration) in sortedSteps {
            let percentage = (duration / totalTime) * 100
            let paddedName = stepName.padding(toLength: 25, withPad: " ", startingAt: 0)
            report += String(format: "  %@: %6.0fms (%4.1f%%)\n", 
                           paddedName, duration * 1000, percentage)
        }
        
        report += "\n" + String(repeating: "=", count: 40)
        
        return report
    }
    
    func printReport() {
        print(generateReport())
    }
    
    func identifyBottlenecks(threshold: TimeInterval = 0.1) -> [String] {
        return stepTimes.withLock { times in
            return times.compactMap { stepName, duration in
                duration > threshold ? stepName : nil
            }.sorted { times[$0] ?? 0 > times[$1] ?? 0 }
        }
    }
}
