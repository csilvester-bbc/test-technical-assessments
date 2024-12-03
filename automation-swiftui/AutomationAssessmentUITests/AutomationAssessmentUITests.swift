//
//  AutomationAssessmentUITests.swift
//  AutomationAssessmentUITests
//
//  Created by Nicholas Jones - Mobile iPlayer - Erbium on 29/10/2024.
//

import XCTest

final class AutomationAssessmentUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        app = XCUIApplication()
        app.launch()
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        app.terminate()
        app = nil
        try super.tearDownWithError()
    }

    func testMainPageLoadsWithExpectedContent() throws {
        // This opens the app and calls waitForPage which checks the expected content is rendered
        TestingPageModel(app: app).waitForPage()
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
    
    
    func testCheckRefreshButtonWorks() throws {
        TestingPageModel(app: app).waitForPage()
            .assertTimeChangesAfterRefresh()
    }
        
    func testSelectTechnologyFromPicker() throws {
        TestingPageModel(app: app).waitForPage()
            .assertGoToPolitics()
            .tapOnTopicSelect()
            .tapOnTechnology()
            .assertGoToTechnology()
        }
    
    func testNavigateToTechnologyPage() throws {
        TestingPageModel(app: app).waitForPage()
            .assertGoToPolitics()
            .tapOnTopicSelect()
            .tapOnTechnology()
            .assertGoToTechnology()
            .tapOnGoToTechnology()
            .assertTechnologyContent()
            .swipeUpXTimes(5)
        // find end of text - properly :O
            .checkForEndOfPlaceholderText()
            .tapOnBackButton()
            .waitForPage()
    }
    
    func testNoTvLicense() throws {
        TestingPageModel(app: app).waitForPage()
            .tapOnTopicSelect()
            .tapOnTvGuide()
            .assertGoToTvGuide()
            .tapOnGoToTvGuide()
            .assertTvGuidePopup()
            .tapNoTvLicense()
            .waitForPage()
    }
    
    func testOpenTVGuide() throws {
        TestingPageModel(app: app).waitForPage()
            .tapOnTopicSelect()
            .tapOnTvGuide()
            .assertGoToTvGuide()
            .tapOnGoToTvGuide()
            .assertTvGuidePopup()
            .tapYesTvLicense()
            .assertTvGuideContent()
            .tapOnBackButton()
            .waitForPage()
    }
    
    func testTapOnBreakingNewsAndDismissPopup() throws {
        TestingPageModel(app: app).waitForPage()
            .tapOnBreakingNews()
            .assertSomethingHasGoneWrong()
            .tapOnOkButton()
            .waitForPage()
    }
    

}
