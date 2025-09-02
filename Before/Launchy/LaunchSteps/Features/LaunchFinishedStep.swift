//
//  LaunchFinishedStep.swift
//  Launchy
//
//  Created by Jacob Bartlett on 29/08/2025.
//

import Foundation

class LaunchFinishedStep: LaunchStep {
    let name = "LaunchFinished"
    
    func execute() {
        Thread.sleep(forTimeInterval: 0.005) // 5ms
        
        // Post app-wide notification that launch is complete
        NotificationCenter.default.post(
            name: Notification.Name("AppLaunchCompleted"),
            object: nil,
            userInfo: ["timestamp": Date()]
        )
        
        print("✅ Launch sequence completed - App ready!")
    }
}
