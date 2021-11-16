//
//  Crowd_MonitorUITests.swift
//  Crowd MonitorUITests
//
//  Created by Swamita on 19/03/21.
//

import XCTest

class Crowd_MonitorUITests: XCTestCase {
    
    let validAdminUsername = "Yash"
    let validAdminCode = "abc123"

    override func setUpWithError() throws {
        continueAfterFailure = false

    }

    override func tearDownWithError() throws {
    }
    
    func isSignedIn(app: XCUIApplication) {
        app.launch()
        app/*@START_MENU_TOKEN@*/.staticTexts["Sign In"]/*[[".buttons[\"Sign In\"].staticTexts[\"Sign In\"]",".staticTexts[\"Sign In\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let enterAdminUsername = app.textFields["Enter Username"]
        XCTAssertTrue(enterAdminUsername.exists)
        enterAdminUsername.tap()
        enterAdminUsername.typeText(validAdminUsername)
        
        let enterAdminCodeTextField = app.textFields["Enter Admin Code"]
        XCTAssertTrue(enterAdminCodeTextField.exists)
        enterAdminCodeTextField.tap()
        enterAdminCodeTextField.typeText(validAdminCode)
        
        let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        element.tap()
        app.staticTexts["Crowd Monitor"].tap()

        app.buttons["Submit"].tap()
    }

    func testSignIn() throws {
        let app = XCUIApplication()
        app.launch()
        let si = app/*@START_MENU_TOKEN@*/.staticTexts["Sign In"]/*[[".buttons[\"Sign In\"].staticTexts[\"Sign In\"]",".staticTexts[\"Sign In\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        XCTAssertTrue(si.exists)
    }
    
    
    func testShowData() {
        
        let app = XCUIApplication()
        isSignedIn(app: app)
        app.tabBars["Tab Bar"].buttons["Log"].tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["View Data >"]/*[[".buttons[\"View Data >\"].staticTexts[\"View Data >\"]",".staticTexts[\"View Data >\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let countView = app.staticTexts["Count Data"]
        XCTAssertTrue(countView.exists)
        
    }
    
    func testScheduleTab() {
        
        let app = XCUIApplication()
        isSignedIn(app: app)
        
        let scheduleTab = app.tabBars["Tab Bar"].buttons["Schedule"]
        XCTAssertTrue(scheduleTab.exists)
    }
    
    func testVisualization() {
        
        let app = XCUIApplication()
        isSignedIn(app: app)
        app.tabBars["Tab Bar"].buttons["Log"].tap()
        app/*@START_MENU_TOKEN@*/.buttons["Yesterday"]/*[[".segmentedControls.buttons[\"Yesterday\"]",".buttons[\"Yesterday\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let chartView = app/*@START_MENU_TOKEN@*/.staticTexts["View Data >"]/*[[".buttons[\"View Data >\"].staticTexts[\"View Data >\"]",".staticTexts[\"View Data >\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        XCTAssertTrue(chartView.exists)
                      
    }
    
    func testLogOutSuccess() {
        
        let app = XCUIApplication()
        isSignedIn(app: app)
        let tabBar = app.tabBars["Tab Bar"]
        
        tabBar.buttons["Log"].tap()
        app/*@START_MENU_TOKEN@*/.staticTexts[" Log Out"]/*[[".buttons[\" Log Out\"].staticTexts[\" Log Out\"]",".staticTexts[\" Log Out\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let appInitText = app.staticTexts["Crowd Monitor"]
        XCTAssertTrue(appInitText.exists)
    }
    
    func testValidLoginSuccess() {
        
        let app = XCUIApplication()
        isSignedIn(app: app)
        let appInitText = app.staticTexts["Crowd Monitor"]
        XCTAssertTrue(appInitText.exists)
    }
    
}
