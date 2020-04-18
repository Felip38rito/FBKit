//
//  FBValidatorTest.swift
//  FBKitTests
//
//  Created by Felipe Correia on 17/04/20.
//  Copyright © 2020 Felip38rito. All rights reserved.
//

import XCTest
@testable import FBKit

class FBValidatorTest: XCTestCase {
    
    private var emailValidator: FBEmailValidator!
    private var requiredValidator: FBRequiredValidator!
    private var cellphoneValidator: FBCellphoneValidator!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        emailValidator = FBEmailValidator()
        requiredValidator = FBRequiredValidator()
        cellphoneValidator = FBCellphoneValidator()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        emailValidator = nil
        requiredValidator = nil
        cellphoneValidator = nil
    }
    
    func testCanValidateEmail() {
        // my email is valid: letters and numbers
        XCTAssertTrue(emailValidator.isValid("felip38rito@gmail.com"))
        XCTAssertTrue(emailValidator.isValid("onlyletters@gmail.com"))
        /// only a empty string is not valid
        XCTAssertFalse(emailValidator.isValid(""))
        /// two @ is not valid
        XCTAssertFalse(emailValidator.isValid("felip@teds@gmail.com"))
    }
    
    func testCanValidateRequiredField() {
        XCTAssertFalse(requiredValidator.isValid(""))
        XCTAssertFalse(requiredValidator.isValid("     "))
        XCTAssertTrue(requiredValidator.isValid("something"))
    }
    
    func testCanValidateBrasilianCellphone() {
        XCTAssertTrue(cellphoneValidator.isValid("(12) 1234-5678"))
        XCTAssertTrue(cellphoneValidator.isValid("(42) 91234-5678"))
        XCTAssertFalse(cellphoneValidator.isValid(""))
        XCTAssertFalse(cellphoneValidator.isValid("1234-1234"))
    }
}
