//
//  SignupValidationTests.swift
//  GoAroundNewsAppTests
//
//  Created by Dyana Varghese on 03/01/23.
//

import XCTest
@testable import GoAroundNewsApp

final class SignupValidationTests: XCTestCase {
    
    let networkService = NetworkService()

    func test_signupValidation_emptyFields() {
        let credential = Credential(phone: "",
                                    name: "",
                                    email: "",
                                    password: "",
                                    confirmPassword: "")
        let viewModel = SignupViewModel(networkService: networkService,
                                        credential: credential)
        let result = viewModel.signUpDisabled
        XCTAssertEqual(result, true)
    }
    
    func test_SignupValidation_validFields_But_PasswordMismatch() {
        let credential = Credential(phone: "1234567890",
                                    name: "Dyana",
                                    email: "abc@gmail.com",
                                    password: "123456",
                                    confirmPassword: "123455")
        let viewModel = SignupViewModel(networkService: networkService,
                                        credential: credential)
        let result = viewModel.signUpDisabled
        XCTAssertEqual(result, true)
    }
    
    func test_SignupValidation_validFields() {
        let credential = Credential(phone: "1234567890",
                                    name: "Dyana",
                                    email: "abc@gmail.com",
                                    password: "123456",
                                    confirmPassword: "123456")
        let viewModel = SignupViewModel(networkService: networkService,
                                        credential: credential)
        let result = viewModel.signUpDisabled
        XCTAssertEqual(result, false)
        
        let credential1 = Credential(phone: "1234567890",
                                     name: "Dyana",
                                     email: "abc@gmail.co",
                                     password: "123456",
                                     confirmPassword: "123456")
        let viewModel1 = SignupViewModel(networkService: networkService,
                                         credential: credential1)
        let result1 = viewModel1.signUpDisabled
        XCTAssertEqual(result1, false)
    }
}
