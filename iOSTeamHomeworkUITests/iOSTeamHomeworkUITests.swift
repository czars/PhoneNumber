//
//  iOSTeamHomeworkUITests.swift
//  iOSTeamHomeworkUITests
//
//  Created by willsbor Kang on 2017/9/16.
//  Copyright © 2017年 gogolook. All rights reserved.
//

import XCTest

class iOSTeamHomeworkUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDisplayCreateNumberViewController() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

        let app = XCUIApplication()
        app.navigationBars["Phone Numbers"]/*@START_MENU_TOKEN@*/.buttons["addNumber"]/*[[".buttons[\"Add\"]",".buttons[\"addNumber\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()

        let createnumberButton = app/*@START_MENU_TOKEN@*/.buttons["createNumber"]/*[[".buttons[\"Add new number\"]",".buttons[\"createNumber\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        createnumberButton.tap()
        let warningLabel = app.staticTexts["warningLabel"]
        XCTAssertTrue(createnumberButton.exists)
        XCTAssertFalse(warningLabel.exists)
        createnumberButton.tap()
        XCTAssertTrue(warningLabel.exists)
        
    }


    func testSaveNumberAction() {
        let app = XCUIApplication()
        app.navigationBars["Phone Numbers"]/*@START_MENU_TOKEN@*/.buttons["saveNumber"]/*[[".buttons[\"Save\"]",".buttons[\"saveNumber\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        XCTAssertTrue(app.alerts.element.staticTexts["save number successed"].exists)
    }

    func testInputNewNumberAndAddNumber() {
        let app = XCUIApplication()
        let createnumberButton = app.buttons["createNumber"]
        app.navigationBars["Phone Numbers"]/*@START_MENU_TOKEN@*/.buttons["addNumber"]/*[[".buttons[\"Add\"]",".buttons[\"addNumber\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let codeTextfield = app.textFields["codeTextField"]
        codeTextfield.typeText("1")
        createnumberButton.tap()
        let numberTextField = app.textFields["numberTextField"]
        numberTextField.typeText("111")
        createnumberButton.tap()
        let warningLabel = app.staticTexts["warningLabel"]
        XCTAssertTrue(warningLabel.label == "created new number")
    }
    
}
