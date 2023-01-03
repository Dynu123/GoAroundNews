//
//  ChangePasswordTests.swift
//  GoAroundNewsAppTests
//
//  Created by Dyana Varghese on 03/01/23.
//

import XCTest
@testable import GoAroundNewsApp
import Combine
import Alamofire
import Mocker

final class ChangePasswordTests: XCTestCase {

    // MARK: - Test for validating data on successful API call
    func test_changepassword_api_onsuccess() throws {
        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [MockingURLProtocol.self] + (configuration.protocolClasses ?? [])
        let sessionManager = Session(configuration: configuration)
        
        let query = UpdatePasswordQuery(currentPassword: "1", newPassword: "123", confirmPassword: "123")
        let endpoint = API.changePassword(query: query).requestURL
        let successResponse = SuccessResponse(code: "200", message: "Success", data: true)
        
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
                    let successResponse = try decoder.decode(SuccessResponse<Bool>.self, from: response.value!)
                    XCTAssertNotNil(successResponse.data)
                    XCTAssertEqual(successResponse.data, true)
                } catch { }
                requestExpectation.fulfill()
            }
            .resume()
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    // MARK: - Test for validating data on failure API call
    func test_test_changepassword_api_onsuccess_api_onfailure() throws {
        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [MockingURLProtocol.self] + (configuration.protocolClasses ?? [])
        let sessionManager = Session(configuration: configuration)
        
        let query = UpdatePasswordQuery(currentPassword: "1", newPassword: "123", confirmPassword: "123")
        let endpoint = API.changePassword(query: query).requestURL
        
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
