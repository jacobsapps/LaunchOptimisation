//
//  DependencyResolver.swift
//  Launchy
//
//  Created by Jacob Bartlett on 29/08/2025.
//

import Foundation

actor DependencyResolver {
    private var completedSteps: [LaunchStep.Type] = []
    private var pendingSteps: [LaunchStep] = []
    
    init(steps: [LaunchStep]) {
        self.pendingSteps = steps
    }
    
    func getAndClaimNextAvailableStep() -> LaunchStep? {
        // Find all steps whose dependencies are satisfied
        let availableSteps = pendingSteps.filter { step in
            step.dependencies.allSatisfy { dependencyType in
                completedSteps.contains { completedType in
                    String(describing: dependencyType) == String(describing: completedType)
                }
            }
        }
        
        // Get the highest priority available step
        guard let nextStep = availableSteps.max(by: { lhs, rhs in
            lhs.priority.rawValue < rhs.priority.rawValue
        }) else {
            return nil
        }
        
        // Atomically remove it from pending steps so no other worker can claim it
        pendingSteps.removeAll { step in
            String(describing: type(of: step)) == String(describing: type(of: nextStep))
        }
        
        return nextStep
    }
    
    func markStepComplete(_ stepType: LaunchStep.Type) {
        completedSteps.append(stepType)
        // Note: Step was already removed from pendingSteps in getAndClaimNextAvailableStep()
    }
    
    func allStepsComplete() -> Bool {
        pendingSteps.isEmpty
    }
    
    func getRemainingStepCount() -> Int {
        pendingSteps.count
    }
    
    func getCompletedStepCount() -> Int {
        completedSteps.count
    }
}
