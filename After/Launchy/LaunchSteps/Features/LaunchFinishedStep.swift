//
//  LaunchFinishedStep.swift
//  Launchy
//
//  Created by Jacob Bartlett on 29/08/2025.
//

import Foundation

class LaunchFinishedStep: LaunchStep {
    let name = "LaunchFinished"
    let dependencies: [LaunchStep.Type] = [
        // All previous steps
        AppConfigStep.self, LoggingConfigurationStep.self, NetworkMonitoringStep.self, SecureStorageStep.self,
        UserDefaultsStep.self, AudioSessionStep.self, CrashReportingStep.self, DatabaseSchemaStep.self,
        APIConfigurationStep.self, DIContainerStep.self, FeatureFlagsStep.self, PermissionsStep.self,
        PersistenceStep.self, CacheConfigurationStep.self, MigrationStep.self, AuthStep.self, ListenersStep.self,
        AnalyticsStep.self, PushNotificationsStep.self, RemoteConfigurationStep.self, DeepLinksStep.self,
        InAppPurchaseStep.self, CriticalFeaturesStep.self, NonCriticalFeaturesStep.self, ABTestingStep.self,
        PhotoProcessingStep.self, LiveActivitiesStep.self
    ]
    let priority = LaunchPriority.high

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
