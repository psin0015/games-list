//
//  Games_ListUITests.swift
//  Games ListUITests
//
//  Created by Prashant Singh on 23/1/22.
//

import XCTest

class Games_ListUITests: XCTestCase {

    func testDataLoading(){
        let app = XCUIApplication()
        app.launch()
        
        let tableView = app.tables.element(boundBy: 0)
        XCTAssertTrue(tableView.exists)
        let loadingSpinner = app.otherElements.activityIndicators.matching(identifier:"loadingSpinner")
        XCTAssertTrue(loadingSpinner.element.exists)
    }
}
