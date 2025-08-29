//
//  LaunchStepProtocol.swift
//  Launchy
//
//  Created by Jacob Bartlett on 29/08/2025.
//

import Foundation

protocol LaunchStep {
    var name: String { get }
    var dependencies: [String] { get }
    var priority: LaunchPriority { get }
    var isBlocking: Bool { get }
    
    func execute() // Synchronous, blocking execution
}

enum LaunchPriority: Int, CaseIterable {
    case critical = 1000
    case high = 750
    case medium = 500
    case low = 250
}
