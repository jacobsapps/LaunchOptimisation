//
//  DependencyResolver.swift
//  Launchy
//
//  Created by Jacob Bartlett on 29/08/2025.
//

//import Foundation
//
//class DependencyResolver {
//    
//    static func resolveExecutionOrder(for steps: [LaunchStep]) -> [LaunchStep] {
//        var resolved: [LaunchStep] = []
//        var resolvedNames = Set<String>()
//        var remaining = steps
//        
//        while !remaining.isEmpty {
//            let initialCount = remaining.count
//            
//            for (index, step) in remaining.enumerated().reversed() {
//                let dependenciesSatisfied = step.dependencies.allSatisfy { dependencyName in
//                    resolvedNames.contains(dependencyName)
//                }
//                
//                if dependenciesSatisfied {
//                    resolved.append(step)
//                    resolvedNames.insert(step.name)
//                    remaining.remove(at: index)
//                }
//            }
//            
//            // Check for circular dependencies
//            if remaining.count == initialCount {
//                print("⚠️ Warning: Circular dependency detected or missing dependencies:")
//                for step in remaining {
//                    let missingSeps = step.dependencies.filter { !resolvedNames.contains($0) }
//                    print("  - \(step.name) missing: \(missingSeps)")
//                }
//                // Add remaining steps anyway to prevent infinite loop
//                resolved.append(contentsOf: remaining)
//                break
//            }
//        }
//        
//        // Sort by priority within dependency constraints
//        return resolved.sorted { lhs, rhs in
//            lhs.priority.rawValue > rhs.priority.rawValue
//        }
//    }
//}
