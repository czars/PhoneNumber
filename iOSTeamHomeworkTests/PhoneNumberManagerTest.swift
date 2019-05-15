//
//  PhoneNumberManagerTest.swift
//  iOSTeamHomeworkTests
//
//  Created by Paul.Chou on 2019/5/15.
//  Copyright © 2019 gogolook. All rights reserved.
//

import XCTest
@testable import iOSTeamHomework

class PhoneNumberManagerTest: XCTestCase {
    var phoneManager: PhoneNumberManager?

    override func setUp() {
        super.setUp()
        phoneManager = PhoneNumberManager()
    }

    override func tearDown() {
        phoneManager = nil
        super.tearDown()
    }

    func testAddNumber() {
        guard let _manager = phoneManager else {
            XCTFail("Expect inited a phone manager at this point")
            return
        }
        let number = NumberData.init(code: 1, number: 111)
        let number2 = NumberData.init(code: 2, number: 222)

        _manager.add(number)
        XCTAssertTrue(_manager.numbers.count == 1, "add number not success")

        _manager.add(number2)
        XCTAssertTrue(_manager.numbers.count == 2, "add number not success")
    }

    func testRemoveNumber() {
        guard let _manager = phoneManager else {
            XCTFail("Expect inited a phone manager at this point")
            return
        }
        let number = NumberData.init(code: 1, number: 111)

        _manager.add(number)
        XCTAssertTrue(_manager.numbers.count == 1)
        _manager.remove(number)
        XCTAssertTrue(_manager.numbers.count == 0, "remove number failed")
    }

    func testGetCodes() {
        guard let _manager = phoneManager else {
            XCTFail("Expect inited a phone manager at this point")
            return
        }
        let number = NumberData.init(code: 1, number: 111)
        let number2 = NumberData.init(code: 2, number: 222)
        let number3 = NumberData.init(code: 3, number: 333)
        _manager.add(number)
        _manager.add(number2)
        _manager.add(number3)

        let codes = _manager.getCodes()
        XCTAssertTrue(codes[0]==1)
        XCTAssertTrue(codes[1]==2)
        XCTAssertTrue(codes[2]==3)
    }

    func testGetNumbers() {
        guard let _manager = phoneManager else {
            XCTFail("Expect inited a phone manager at this point")
            return
        }
        let number = NumberData.init(code: 1, number: 111)
        let number2 = NumberData.init(code: 1, number: 222)
        let number3 = NumberData.init(code: 1, number: 333)
        _manager.add(number)
        _manager.add(number2)
        _manager.add(number3)

        let numbers = _manager.getNumbers(for: 1)
        XCTAssertTrue(numbers[0]==NumberData.init(code: 1, number: 111))
        XCTAssertTrue(numbers[1]==NumberData.init(code: 1, number: 222))
        XCTAssertTrue(numbers[2]==NumberData.init(code: 1, number: 333))
    }

    func testCheckForExist() {
        guard let _manager = phoneManager else {
            XCTFail("Expect inited a phone manager at this point")
            return
        }
        let number = NumberData.init(code: 1, number: 111)
        _manager.add(number)
        let exist = _manager.checkExist(NumberData.init(code: 1, number: 111))
        XCTAssertTrue(exist, "should have number")
    }
}
