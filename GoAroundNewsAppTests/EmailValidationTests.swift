//
//  GoAroundNewsAppTests.swift
//  GoAroundNewsAppTests
//
//  Created by Dyana Varghese on 07/12/22.
//

import XCTest
@testable import GoAroundNewsApp

final class EmailValidationTests: XCTestCase {
    func test_email_invalid() {
        let credential1 = Credential(email: "abc", password: "")
        let result1 = credential1.isValidEmail
        XCTAssertEqual(result1, false)
        
        let credential2 = Credential(email: ".com", password: "")
        let result2 = credential2.isValidEmail
        XCTAssertEqual(result2, false)
        
        let credential3 = Credential(email: "abc.com", password: "")
        let result3 = credential3.isValidEmail
        XCTAssertEqual(result3, false)
        
        let credential4 = Credential(email: "abc@com", password: "")
        let result4 = credential4.isValidEmail
        XCTAssertEqual(result4, false)
    }
    
    func test_email_valid() {
        let credential1 = Credential(email: "abc@gmail.com", password: "")
        let result1 = credential1.isValidEmail
        XCTAssertEqual(result1, true)
        
        let credential2 = Credential(email: "abc@gmail.co", password: "")
        let result2 = credential2.isValidEmail
        XCTAssertEqual(result2, true)
    }
    
    func test_email_empty() {
        let credential1 = Credential(email: "", password: "")
        let result1 = credential1.isValidEmail
        XCTAssertEqual(result1, false)
        
    }
    
}
