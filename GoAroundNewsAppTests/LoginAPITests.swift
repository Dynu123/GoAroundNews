//
//  LoginAPITests.swift
//  GoAroundNewsAppTests
//
//  Created by Dyana Varghese on 10/12/22.
//

import XCTest
@testable import GoAroundNewsApp
import Combine
import Alamofire
import Mocker

final class MockSession {
    
    private init() {
        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [MockingURLProtocol.self] + (configuration.protocolClasses ?? [])
        mockSessionManager = Session(configuration: configuration)
    }
    static var shared = MockSession()
    let mockSessionManager: Session
}


final class LoginAPITests: XCTestCase {
    
    // MARK: - Test for validating data on successful API call
    func test_login_api_onsuccess() throws {
        let sessionManager = MockSession.shared.mockSessionManager
        let credential = Credential(email: "dyana@yopmail.com", password: "1")
        let endpoint = API.login(credential: credential).requestURL
        let expectedUser = User(id: 1, email: credential.email, token: "", name: "Dyana", phone: "5431234567")
        let successResponse = SuccessResponse(code: "200", message: "Success", data: expectedUser)
        let mockedData = try! JSONEncoder().encode(successResponse)
        let mock = Mock(url: endpoint, dataType: .json, statusCode: 200, data: [.get: mockedData])
        let requestExpectation = expectation(description: "Request should finish")
        mock.register()
        
        sessionManager
            .request(endpoint)
            .responseData { (response: DataResponse<Data, AFError>) in
                XCTAssertNil(response.error)
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let successResponse = try decoder.decode(SuccessResponse<User>.self, from: response.value!)
                    
                    XCTAssertNotNil(successResponse.data)
                    XCTAssertEqual(successResponse.data.email, expectedUser.email)
                } catch {
                }
                requestExpectation.fulfill()
            }.resume()
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    // MARK: - Test for validating data on failure API call
    func test_login_api_onfailure() throws {
        let sessionManager = MockSession.shared.mockSessionManager
        let credential = Credential(email: "dyana@yopmail.com", password: "1")
        let endpoint = API.login(credential: credential).requestURL
        let error = NSError(domain: "Bad request", code: 400)
        let expectedFailure = FailureResponse(code: "\(error.code)", message: error.domain)
        let mockedData = try! JSONEncoder().encode(expectedFailure)
        let requestExpectation = expectation(description: "Request should finish")
        let mock = Mock(url: endpoint, dataType: .json, statusCode: error.code, data: [.get: mockedData])
        
        mock.register()
        
        sessionManager
            .request(endpoint)
            .responseData { (response: DataResponse<Data, AFError>) in
                do {
                    let failureResponse = try JSONDecoder().decode(FailureResponse.self, from: response.value!)
                    XCTAssertNotNil(failureResponse)
                    XCTAssertEqual(failureResponse.code, expectedFailure.code)
                } catch {
                    
                }
                requestExpectation.fulfill()
            }.resume()
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
}
