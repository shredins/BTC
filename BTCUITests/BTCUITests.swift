//
//  BTCUITests.swift
//  BTCUITests
//
//  Created by Tomasz Korab on 11/02/2020.
//  Copyright © 2020 Tomasz Korab. All rights reserved.
//

import XCTest

class BTCUITests: XCTestCase {

    override func setUp() {
        continueAfterFailure = false
    }

    override func tearDown() {}

    func testInitialUISetup() {
        let app = XCUIApplication()
        app.launch()
        let button = app.buttons["subscibe.button.identifier"]
        XCTAssertTrue(button.exists)
    }

}
