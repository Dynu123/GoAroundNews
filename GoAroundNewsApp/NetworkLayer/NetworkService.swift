//
//  NetworkService.swift
//  GoAroundNewsApp
//
//  Created by Dyana Varghese on 08/12/22.
//

import Foundation
import Combine
import Alamofire


// MARK: - NetworkServiceProtocol to execute URLRequest
protocol NetworkServiceProtocol: AnyObject {
    func execute<T: Codable>(_ urlRequest: URLRequestBuilder, completion: @escaping (Result<T, ServiceError>) -> Void) -> AnyCancellable
}

// MARK: - Extend NetworkServiceProtocol to implement the method
extension NetworkServiceProtocol {
    func execute<T: Decodable>(_ urlRequest: URLRequestBuilder,completion: @escaping (Result<T, ServiceError>) -> Void) -> AnyCancellable {
        
        let requestPublisher = AF.request(urlRequest).publishDecodable(type: SuccessResponse<T>.self)
        
        let cancellable = requestPublisher
            .subscribe(on: DispatchQueue(label: "Background Queue", qos: .background))
            .receive(on: RunLoop.main)
            .sink { (response) in
                switch response.result {
                case .success:
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let successResponse = try decoder.decode(SuccessResponse<T>.self, from: response.data!)
                        completion(.success(successResponse.data))
                    } catch {
                        do {
                            let failureResponse = try JSONDecoder().decode(FailureResponse.self, from: response.data!)
                            if failureResponse.success {
                                completion(.failure(.serverError(error: error)))
                            } else {
                                completion(.failure(.serverError(message: failureResponse.message)))
                            }
                        } catch {
                            completion(.failure(.serverError(error: error)))
                        }
                    }
                case .failure(let error):
                    completion(.failure(.serverError(error: error)))
                }
            }
        return cancellable
    }
}

public class NetworkService: NetworkServiceProtocol {
    static let `default`: NetworkServiceProtocol = {
        var service = NetworkService()
        return service
    }()
}
