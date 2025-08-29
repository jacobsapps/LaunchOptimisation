//
//  LaunchOrchestrator.swift
//  Launchy
//
//  Created by Jacob Bartlett on 29/08/2025.
//

import Foundation

class LaunchOrchestrator {
    static let shared = LaunchOrchestrator()
    
    private var allSteps: [LaunchStep] = []
    private var executedSteps = Set<String>()
    
    private init() {
        setupAllSteps()
    }
    
    func executeAllStepsBlocking() {
        let startTime = CFAbsoluteTimeGetCurrent()
        print("🚀 Starting app launch sequence...")
        
        // Comment out dependency resolution for worst-case demo
        // let orderedSteps = DependencyResolver.resolveExecutionOrder(for: allSteps)
        
        // Use raw array order - no dependency management (worst case!)
        let orderedSteps = allSteps
        
        for step in orderedSteps {
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
    
    private func setupAllSteps() {
        // Steps are arranged in proper dependency order - DO NOT REORDER without checking dependencies!
        
        // Foundation Layer (no dependencies)
        allSteps.append(AppConfigStep())
        allSteps.append(LoggingConfigurationStep())
        allSteps.append(NetworkMonitoringStep())
        allSteps.append(SecureStorageStep())
        allSteps.append(UserDefaultsStep())
        allSteps.append(AudioSessionStep())
        
        // Infrastructure Layer (depends on Foundation)
        allSteps.append(CrashReportingStep()) // depends on LoggingConfiguration
//        allSteps.append(DatabaseSchemaStep()) // depends on SecureStorage
        allSteps.append(APIConfigurationStep()) // depends on AppConfig, NetworkMonitoring
        allSteps.append(DIContainerStep()) // depends on AppConfig
        allSteps.append(FeatureFlagsStep()) // depends on AppConfig, NetworkMonitoring
        allSteps.append(PermissionsStep()) // depends on UserDefaults
        
        // Data Layer (depends on Infrastructure)
        allSteps.append(PersistenceStep()) // depends on AppConfig, DatabaseSchema - WILL CRASH if DatabaseSchema is missing!
        allSteps.append(CacheConfigurationStep()) // depends on Persistence
        allSteps.append(MigrationStep()) // depends on Persistence, DatabaseSchema
        
        // Services Layer (depends on Data and Infrastructure)
        allSteps.append(AuthStep()) // depends on SecureStorage, APIConfiguration, NetworkMonitoring
        allSteps.append(ListenersStep()) // depends on APIConfiguration, Persistence
        allSteps.append(AnalyticsStep()) // depends on AppConfig, UserDefaults, Auth
        allSteps.append(PushNotificationsStep()) // depends on Auth, APIConfiguration
        allSteps.append(RemoteConfigurationStep()) // depends on APIConfiguration, Auth
        allSteps.append(DeepLinksStep()) // depends on AppConfig, Auth
        allSteps.append(InAppPurchaseStep()) // depends on Auth, APIConfiguration
        
        // Features Layer (depends on Services)
        allSteps.append(CriticalFeaturesStep()) // depends on Persistence, APIConfiguration, FeatureFlags, DIContainer
        allSteps.append(ABTestingStep()) // depends on FeatureFlags, Analytics
        allSteps.append(PhotoProcessingStep()) // depends on Permissions, CacheConfiguration
        allSteps.append(LiveActivitiesStep()) // depends on APIConfiguration, PushNotifications
        allSteps.append(NonCriticalFeaturesStep()) // depends on CriticalFeatures, Analytics
        
        // Final Step (depends on everything)
        allSteps.append(LaunchFinishedStep()) // depends on all previous steps
    }
}
