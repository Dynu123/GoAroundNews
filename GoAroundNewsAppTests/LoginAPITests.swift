//
//  LoginAPITests.swift
//  GoAroundNewsAppTests
//
//  Created by Dyana Varghese on 10/12/22.
//

import XCTest
@testable import GoAroundNewsApp
import Combine


final class LoginAPITests: XCTestCase {
    
    // MARK: - Declare parameters for depedency injection by creating mock network service
    var viewModel: LoginViewModel!
    var networkService: MockNetworkService!
    var credential: Credential!
    
    override func setUp() {
        networkService = MockNetworkService()
        credential = Credential()
        viewModel = .init(networkService: networkService, credential: credential)
    }
    
    // MARK: - Test for validating data on successful API call
    func test_login_api_onsuccess() throws {
        networkService.item = CurrentValueSubject(APIResponse<User>.init(code: "200", message: "sucess", data: .sample)).eraseToAnyPublisher()
        let expectation = expectation(description: "wait for completion")
        viewModel.login {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertNotNil(LocalStorage.user)
        XCTAssertEqual(LocalStorage.user?.name, "Dyana")
        XCTAssertEqual(LocalStorage.user?.email, "Dyana@yopmail.com" )
    }

}
