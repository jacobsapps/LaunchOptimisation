//
//  LaunchyUITests.swift
//  LaunchyUITests
//
//  Created by Jacob Bartlett on 02/09/2025.
//

import XCTest
import FaultOrderingTests

final class LaunchyUITests: XCTestCase {

    // Generate Emerge Tools order file
    @MainActor
    func testExample() throws {
        let app = XCUIApplication()
        let test = FaultOrderingTest { app in
            app.launch()
        }
        test.testApp(testCase: self, app: app)
    }

    // Test launch performance traditionally, as part of a CI pipeline
//    @MainActor
//    func testLaunchPerformance() throws {
//        // This measures how long it takes to launch your application.
//        measure(metrics: [XCTApplicationLaunchMetric()]) {
//            XCUIApplication().launch()
//        }
//    }
}
