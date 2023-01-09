//
//  LoginValidationTests.swift
//  GoAroundNewsAppTests
//
//  Created by Dyana Varghese on 10/12/22.
//

import XCTest
@testable import GoAroundNewsApp

final class LoginValidationTests: XCTestCase {
    let networkService = NetworkService()

    func test_LoginValidation_emptyEmail_And_Password() {
        let credential = Credential(email: "", password: "")
        let viewModel = LoginViewModel(networkService: networkService,
                                       credential: credential)
        let result = viewModel.loginDisabled
        XCTAssertEqual(result, true)
    }

    func test_LoginValidation_validEmail_But_EmptyPassword() {
        let credential = Credential(email: "abc@gmail.com", password: "")
        let viewModel = LoginViewModel(networkService: networkService,
                                       credential: credential)
        let result = viewModel.loginDisabled
        XCTAssertEqual(result, true)
    }
    
    func test_LoginValidation_validEmail_And_ValidPassword() {
        let credential = Credential(email: "abc@gmail.com", password: "123456")
        let viewModel = LoginViewModel(networkService: networkService,
                                       credential: credential)
        let result = viewModel.loginDisabled
        XCTAssertEqual(result, false)
        
        let credential1 = Credential(email: "abc@gmail.co", password: "123456")
        let viewModel1 = LoginViewModel(networkService: networkService,
                                        credential: credential1)
        let result1 = viewModel1.loginDisabled
        XCTAssertEqual(result1, false)
    }

}
