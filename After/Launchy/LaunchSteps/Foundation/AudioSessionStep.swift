//
//  AudioSessionStep.swift
//  Launchy
//
//  Created by Jacob Bartlett on 29/08/2025.
//

import Foundation
import AVFoundation

class AudioSessionStep: LaunchStep {
    let name = "AudioSession"
    let dependencies: [String] = []
    let priority = LaunchPriority.low
    let isBlocking = true
    
    func execute() {
        Thread.sleep(forTimeInterval: 0.005) // 5ms
        
        // Configure AVAudioSession category and mode
        do {
            let audioSession = AVAudioSession.sharedInstance()
            try audioSession.setCategory(.playback, mode: .default)
        } catch {
            print("Audio session configuration failed: \(error)")
        }
        
        print("✓ Audio Session initialized")
    }
}
