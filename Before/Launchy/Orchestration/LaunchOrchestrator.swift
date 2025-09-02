//
//  LaunchOrchestrator.swift
//  Launchy
//
//  Created by Jacob Bartlett on 29/08/2025.
//

import Foundation

class LaunchOrchestrator {
    static let shared = LaunchOrchestrator()
    
    private var launchSteps: [LaunchStep] = []
    private var executedSteps = Set<String>()
    
    private init() {
        setupLaunchSteps()
    }
    
    func executeLaunchSteps() {
        let startTime = CFAbsoluteTimeGetCurrent()
        print("🚀 Starting app launch sequence...")
        
        for step in launchSteps {
            let stepStartTime = CFAbsoluteTimeGetCurrent()
            
            print("⚡ Executing: \(step.name)")
            step.execute()
            executedSteps.insert(step.name)
            
            let stepDuration = CFAbsoluteTimeGetCurrent() - stepStartTime
            print("✅ Completed: \(step.name) in \(String(format: "%.1f", stepDuration * 1000))ms")
            
            // Record step time in profiler
            LaunchTimeProfiler.shared.recordStepTime(step.name, duration: stepDuration)
        }
        
        let totalTime = CFAbsoluteTimeGetCurrent() - startTime
        print("🎉 Launch sequence completed in \(String(format: "%.2f", totalTime))s")
    }
    
    private func setupLaunchSteps() {
        // Steps are arranged in proper dependency order - DO NOT REORDER without checking dependencies!
        
        // Foundation Layer (no dependencies)
        launchSteps.append(AppConfigStep())
        launchSteps.append(LoggingConfigurationStep())
        launchSteps.append(NetworkMonitoringStep())
        launchSteps.append(SecureStorageStep())
        launchSteps.append(UserDefaultsStep())
        launchSteps.append(AudioSessionStep())
        
        // Infrastructure Layer (depends on Foundation)
        launchSteps.append(CrashReportingStep()) // depends on LoggingConfiguration
//        launchSteps.append(DatabaseSchemaStep()) // depends on SecureStorage
        launchSteps.append(APIConfigurationStep()) // depends on AppConfig, NetworkMonitoring
        launchSteps.append(DIContainerStep()) // depends on AppConfig
        launchSteps.append(FeatureFlagsStep()) // depends on AppConfig, NetworkMonitoring
        launchSteps.append(PermissionsStep()) // depends on UserDefaults
        
        // Data Layer (depends on Infrastructure)
        launchSteps.append(PersistenceStep()) // depends on AppConfig, DatabaseSchema - WILL CRASH if DatabaseSchema is missing!
        launchSteps.append(CacheConfigurationStep()) // depends on Persistence
        launchSteps.append(MigrationStep()) // depends on Persistence, DatabaseSchema
        
        // Services Layer (depends on Data and Infrastructure)
        launchSteps.append(AuthStep()) // depends on SecureStorage, APIConfiguration, NetworkMonitoring
        launchSteps.append(ListenersStep()) // depends on APIConfiguration, Persistence
        launchSteps.append(AnalyticsStep()) // depends on AppConfig, UserDefaults, Auth
        launchSteps.append(PushNotificationsStep()) // depends on Auth, APIConfiguration
        launchSteps.append(RemoteConfigurationStep()) // depends on APIConfiguration, Auth
        launchSteps.append(DeepLinksStep()) // depends on AppConfig, Auth
        launchSteps.append(InAppPurchaseStep()) // depends on Auth, APIConfiguration
        
        // Features Layer (depends on Services)
        launchSteps.append(CriticalFeaturesStep()) // depends on Persistence, APIConfiguration, FeatureFlags, DIContainer
        launchSteps.append(ABTestingStep()) // depends on FeatureFlags, Analytics
        launchSteps.append(PhotoProcessingStep()) // depends on Permissions, CacheConfiguration
        launchSteps.append(LiveActivitiesStep()) // depends on APIConfiguration, PushNotifications
        launchSteps.append(NonCriticalFeaturesStep()) // depends on CriticalFeatures, Analytics
        
        // Final Step (depends on everything)
        launchSteps.append(LaunchFinishedStep()) // depends on all previous steps
    }
}
