//
//  DependencyResolver.swift
//  Launchy
//
//  Created by Jacob Bartlett on 29/08/2025.
//

import Foundation

/// Optimised version of the dependency resolution logic that avoids the O(n^2) algorithm for resolution
///
//actor DependencyResolver {
//    private var completedSteps = Set<String>()
//    private var pendingSteps: [LaunchStep] = []
//    private var dependencyCount: [String: Int] = [:]
//    private var availableSteps: [LaunchStep] = []
//    
//    init(steps: [LaunchStep]) {
//        self.pendingSteps = steps
//        
//        // Pre-compute dependency counts and find initially available steps
//        for step in steps {
//            let stepName = step.name
//            let unsatisfiedDeps = step.dependencies.count
//            dependencyCount[stepName] = unsatisfiedDeps
//            
//            if unsatisfiedDeps == 0 {
//                availableSteps.append(step)
//            }
//        }
//        
//        // Sort available steps by priority (highest first)
//        availableSteps.sort { $0.priority.rawValue > $1.priority.rawValue }
//    }
//    
//    func getAndClaimNextAvailableStep() -> LaunchStep? {
//        // O(1) - just pop from pre-sorted available queue
//        guard !availableSteps.isEmpty else { return nil }
//        
//        let nextStep = availableSteps.removeFirst()
//        
//        // Remove from pending steps
//        pendingSteps.removeAll { $0.name == nextStep.name }
//        
//        return nextStep
//    }
//    
//    func markStepComplete(_ stepType: LaunchStep.Type) {
//        let completedStepName = String(describing: stepType)
//        completedSteps.insert(completedStepName)
//        
//        // Update dependency counts and move newly available steps to queue
//        var newlyAvailable: [LaunchStep] = []
//        
//        for step in pendingSteps {
//            let stepName = step.name
//            guard var depCount = dependencyCount[stepName] else { continue }
//            
//            // Check if this completion satisfies any of this step's dependencies
//            for dependency in step.dependencies {
//                let depName = String(describing: dependency)
//                if depName == completedStepName {
//                    depCount -= 1
//                    dependencyCount[stepName] = depCount
//                    break
//                }
//            }
//            
//            // If all dependencies are now satisfied, add to available queue
//            if depCount == 0 {
//                newlyAvailable.append(step)
//                dependencyCount.removeValue(forKey: stepName)
//            }
//        }
//        
//        // Add newly available steps and re-sort by priority
//        availableSteps.append(contentsOf: newlyAvailable)
//        availableSteps.sort { $0.priority.rawValue > $1.priority.rawValue }
//    }
//    
//    func allStepsComplete() -> Bool {
//        pendingSteps.isEmpty
//    }
//    
//    func getRemainingStepCount() -> Int {
//        pendingSteps.count
//    }
//    
//    func getCompletedStepCount() -> Int {
//        completedSteps.count
//    }
//}
