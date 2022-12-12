//
//  MockNetworkService.swift
//  GoAroundNewsAppTests
//
//  Created by Dyana Varghese on 10/12/22.
//

import XCTest
@testable import GoAroundNewsApp
import Combine
import Alamofire


// MARK: - Class for mocking NetworkServiceProtocol
class MockNetworkService: NetworkServiceProtocol {
    var item: AnyPublisher<Any, Error>?
    
    func execute<T: Decodable>(_ urlRequest: URLRequestBuilder,completion: @escaping (Result<T, ServiceError>) -> Void) -> AnyCancellable {
        
        //let requestPublisher = AF.request(urlRequest).publishDecodable(type: SuccessResponse<T>.self)
        if let result = self.item?.eraseToAnyPublisher() {
            let cancellable = result
                .subscribe(on: DispatchQueue(label: "Background Queue", qos: .background))
                .receive(on: RunLoop.main)
                .sink { (errorCompletion) in
                    switch errorCompletion {
                    case .failure(let error):
                        completion(.failure(error as! ServiceError))
                    case .finished: break
                    }
                } receiveValue: { response in
                    print(response)
                    completion(.success(response as! T))
                }
            
            return cancellable
        } else {
            fatalError("Result cannot be nil")
        }
        
    }
    //
    //    func execute<T>(_ urlRequest: URLRequestBuilder, model: T.Type, completion: @escaping (Result<T, ServiceError>) -> Void) -> AnyCancellable where T : Decodable, T : Encodable {
    //        if let result = self.item?.eraseToAnyPublisher() {
    //            let cancellable =  result
    //                .subscribe(on: DispatchQueue(label: "Background Queue", qos: .background))
    //                .receive(on: RunLoop.main)
    //                .sink { errorCompletion in
    //                    switch errorCompletion {
    //                    case .failure(let error):
    //                        completion(.failure(error as! ServiceError))
    //                    case .finished: break
    //                    }
    //                } receiveValue: { response in
    //                    completion(.success(response as! T))
    //                }
    //            return cancellable
    //        } else {
    //            fatalError("Result cannot be nil")
    //        }
    //    }
}
