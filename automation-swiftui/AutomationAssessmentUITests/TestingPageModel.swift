//
//  TestingPageModel.swift
//  AutomationAssessment
//
//  Created by Craig Silvester on 30/11/2024.
//

import XCTest


protocol Page {
    var app: XCUIApplication { get }


    @discardableResult
    func waitForPage() -> Self
}


struct TestingPageModel: Page {
    let app: XCUIApplication
    // Default page content
    var myBbcHeading: XCUIElement { app.staticTexts["My BBC"] }
    var bbcLogo: XCUIElement { app.staticTexts["BBC logo"] }
    var refreshButton: XCUIElement { app.buttons["Refresh"] }
    var bbcLocationImage: XCUIElement { app.images["bbc_location"] }
    var lastUpdatedText: XCUIElement { app.staticTexts.element(matching: .staticText, identifier: "last_updated_label")}
    var tagPicker: XCUIElement { app.buttons.element(matching: .button, identifier: "tag_picker")}
    var thisIsABbcApp: XCUIElement { app.staticTexts["This is a BBC app with all of your favourite BBC content."] }
    var breakingNewsButton: XCUIElement { app.buttons["Breaking News"] }
    var loadingSpinner: XCUIElement { app.activityIndicators["1"] }
    // Go to buttons
    var goToPolitics: XCUIElement { app.buttons["Go to Politics"] }
    var goToUk: XCUIElement { app.buttons["Go to UK"] }
    var goToSport: XCUIElement { app.buttons["Go to Sport"] }
    var goToTechnology: XCUIElement { app.buttons["Go to Technology"] }
    var goToWorld: XCUIElement { app.buttons["Go to World"] }
    var goToTvGuide: XCUIElement { app.buttons["Go to TV Guide"] }
    // Topic selector buttons
    var politicsButton: XCUIElement { app.buttons["Politics"] }
    var ukButton: XCUIElement { app.buttons["UK"] }
    var sportButton: XCUIElement { app.buttons["Sport"] }
    var technologyButton: XCUIElement { app.buttons["Technology"] }
    var worldButton: XCUIElement { app.buttons["World"] }
    var tvGuideButton: XCUIElement { app.buttons["TV Guide"] }
    // Topic headers
    var politicsHeading: XCUIElement { app.staticTexts["Politics"] }
    var ukHeading: XCUIElement { app.staticTexts["UK"] }
    var sportHeading: XCUIElement { app.staticTexts["Sport"] }
    var technologyHeading: XCUIElement { app.staticTexts["Technology"] }
    var worldHeading: XCUIElement { app.staticTexts["World"] }
    var tvGuideHeading: XCUIElement { app.staticTexts["TV Guide"] }
    //Content page
    var backButton: XCUIElement { app.buttons["Back"] }
    var contentText: XCUIElement { app.staticTexts.element(matching: .staticText, identifier: "content_text") }
    //TV License
    var tvLicenseText: XCUIElement { app.staticTexts["Do you have a TV license?"] }
    var noButton: XCUIElement { app.buttons["No"] }
    var yesButton: XCUIElement {app.buttons["Yes"] }
    //Breaking News
    var somethingHasGoneWrong: XCUIElement { app.staticTexts["Something has gone wrong"] }
    var okButton: XCUIElement { app.buttons["Ok"] }

    @discardableResult
    func waitForPage() -> Self {
    // Wait for the first essential element to appear then assert the rest will be there
        XCTAssertTrue(bbcLogo.waitForExistence(timeout: 5))
        XCTAssertTrue(myBbcHeading.exists)
        XCTAssertTrue(refreshButton.exists)
        XCTAssertTrue(bbcLocationImage.exists)
        XCTAssertTrue(lastUpdatedText.exists)
        XCTAssertTrue(thisIsABbcApp.exists)
        XCTAssertTrue(tagPicker.exists)
        XCTAssertTrue(breakingNewsButton.exists)
        return self
    }
    
    @discardableResult
    func tapOnRefreshButton() -> Self {
        refreshButton.tap()
        return self
    }
    
    @discardableResult
    func assertLoadingSpinner() -> Self {
        XCTAssertTrue(loadingSpinner.waitForExistence(timeout: 5))
        return self
    }
    
    @discardableResult
    func getLastUpdatedTime() -> String {
        let lastUpdate = lastUpdatedText.label
        return lastUpdate
    }
    
    @discardableResult
    func assertTimeChangesAfterRefresh() -> Self {
        let timeBefore = getLastUpdatedTime()
        tapOnRefreshButton()
        assertLoadingSpinner()
        loadingSpinner.waitForNonExistence(timeout: 5)
        let timeAfter = getLastUpdatedTime()
        XCTAssertTrue(timeBefore != timeAfter)
        return self
    }
    
    @discardableResult
    func assertGoToPolitics() -> Self {
        XCTAssertTrue(goToPolitics.exists)
        return self
    }
    
    @discardableResult
    func tapOnTopicSelect() -> Self {
        tagPicker.tap()
        return self
    }
    
    @discardableResult
    func assertTopicSelection() -> Self {
        XCTAssertTrue(politicsButton.waitForExistence(timeout: 5))
        XCTAssertTrue(ukButton.exists)
        XCTAssertTrue(sportButton.exists)
        XCTAssertTrue(technologyButton.exists)
        XCTAssertTrue(worldButton.exists)
        XCTAssertTrue(tvGuideButton.exists)
        return self
    }
    
    @discardableResult
    func tapOnTechnology() -> Self {
        technologyButton.tap()
        return self
    }
    
    @discardableResult
    func assertGoToTechnology() -> Self {
        XCTAssertTrue(goToTechnology.waitForExistence(timeout: 5))
        return self
    }
    
    @discardableResult
    func tapOnGoToTechnology() -> Self {
        goToTechnology.tap()
        return self
    }
    
    @discardableResult
    func assertTechnologyContent() -> Self {
        XCTAssertTrue(backButton.waitForExistence(timeout: 5))
        XCTAssertTrue(technologyHeading.exists)
        XCTAssertTrue(contentText.exists)
        return self
    }
    
    @discardableResult
    func swipeUpXTimes(_ numberOfTimes: Int) -> Self {
        for _ in 1...numberOfTimes{
            app.swipeUp()
        }
        return self
    }
    
    @discardableResult
    func checkForEndOfPlaceholderText() -> Self {
        let endOfPlaceholder = "This is the end of the placeholder text."
        XCTAssertNotNil(contentText.label.range(of:endOfPlaceholder))
        return self
    }
    
    @discardableResult
    func tapOnBackButton() -> Self {
        backButton.tap()
        return self
    }
    
    @discardableResult
    func tapOnTvGuide() -> Self {
        tvGuideButton.tap()
        return self
    }
    
    @discardableResult
    func assertGoToTvGuide() -> Self {
        XCTAssertTrue(goToTvGuide.waitForExistence(timeout: 5))
        return self
    }
    
    @discardableResult
    func tapOnGoToTvGuide() -> Self {
        goToTvGuide.tap()
        return self
    }
    
    @discardableResult
    func assertTvGuidePopup() -> Self {
        XCTAssertTrue(tvLicenseText.waitForExistence(timeout: 5))
        XCTAssertTrue(noButton.exists)
        XCTAssertTrue(yesButton.exists)
        return self
    }
    
    @discardableResult
    func tapNoTvLicense() -> Self {
        noButton.tap()
        return self
    }
    
    @discardableResult
    func tapYesTvLicense() -> Self {
        yesButton.tap()
        return self
    }
    
    @discardableResult
    func assertTvGuideContent() -> Self {
        XCTAssertTrue(backButton.waitForExistence(timeout: 5))
        XCTAssertTrue(tvGuideHeading.exists)
        XCTAssertTrue(contentText.exists)
        return self
    }
    
    @discardableResult
    func tapOnBreakingNews() -> Self {
        breakingNewsButton.tap()
        return self
    }
    
    @discardableResult
    func assertSomethingHasGoneWrong() -> Self {
        XCTAssertTrue(somethingHasGoneWrong.waitForExistence(timeout: 5))
        XCTAssertTrue(okButton.exists)
        return self
    }
    
    @discardableResult
    func tapOnOkButton() -> Self {
        okButton.tap()
        return self
    }
    
}
