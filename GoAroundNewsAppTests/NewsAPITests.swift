//
//  NewsAPITests.swift
//  GoAroundNewsAppTests
//
//  Created by Dyana Varghese on 03/01/23.
//

import XCTest
@testable import GoAroundNewsApp
import Combine
import Alamofire
import Mocker

final class NewsAPITests: XCTestCase {

    // MARK: - Test for validating data on successful API call - top news
    func test_topnews_api_onsuccess() throws {
        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [MockingURLProtocol.self] + (configuration.protocolClasses ?? [])
        let sessionManager = Session(configuration: configuration)
        
        let endpoint = API.getTopNews(country: .Ireland, category: .general).requestURL
        let expectedNews = Array(repeating: News.sample, count: 5)
        let successResponse = SuccessResponse(code: "200", message: "Success", data: expectedNews)
        let mockedData = try! JSONEncoder().encode(successResponse)
        let mock = Mock(url: endpoint, dataType: .json, statusCode: 200, data: [.get: mockedData])
        let requestExpectation = expectation(description: "Request should finish")
        mock.register()
        
        sessionManager
            .request(endpoint)
            .responseData { (response: DataResponse<Data, AFError>) in
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let successResponse = try decoder.decode(SuccessResponse<[News]>.self, from: response.value!)
                    XCTAssertNil(response.error)
                    XCTAssertNotNil(successResponse.data)
                    XCTAssertEqual(successResponse.data.count, expectedNews.count)
                } catch {
                }
                requestExpectation.fulfill()
            }.resume()
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    // MARK: - Test for validating data on failure API call - top news
    func test_topnews_api_onfailure() throws {
        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [MockingURLProtocol.self] + (configuration.protocolClasses ?? [])
        let sessionManager = Session(configuration: configuration)
        
        let endpoint = API.getTopNews(country: .Ireland, category: .general).requestURL
        
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
    
    // MARK: - Test for validating data on successful API call - search news
    func test_searchnews_api_onsuccess() throws {
        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [MockingURLProtocol.self] + (configuration.protocolClasses ?? [])
        let sessionManager = Session(configuration: configuration)
        
        let endpoint = API.getNewsOnSearch(text: "apple").requestURL
        let expectedNews = Array(repeating: News.sample, count: 5)
        let successResponse = SuccessResponse(code: "200", message: "Success", data: expectedNews)
        let mockedData = try! JSONEncoder().encode(successResponse)
        let mock = Mock(url: endpoint, dataType: .json, statusCode: 200, data: [.get: mockedData])
        let requestExpectation = expectation(description: "Request should finish")
        mock.register()
        
        sessionManager
            .request(endpoint)
            .responseData { (response: DataResponse<Data, AFError>) in
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let successResponse = try decoder.decode(SuccessResponse<[News]>.self, from: response.value!)
                    XCTAssertNil(response.error)
                    XCTAssertNotNil(successResponse.data)
                    XCTAssertEqual(successResponse.data.count, expectedNews.count)
                } catch {
                }
                requestExpectation.fulfill()
            }.resume()
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    // MARK: - Test for validating data on failure API call - search news
    func test_searchnews_api_onfailure() throws {
        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [MockingURLProtocol.self] + (configuration.protocolClasses ?? [])
        let sessionManager = Session(configuration: configuration)
        
        let endpoint = API.getNewsOnSearch(text: "apple").requestURL
        
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
