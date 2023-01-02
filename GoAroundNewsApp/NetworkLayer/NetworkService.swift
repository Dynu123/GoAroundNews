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
    func execute<T: Codable>(_ urlRequest: URLRequestBuilder, completion: @escaping (Result<T, ServiceError>, Int?) -> Void)
}

// MARK: - Extend NetworkServiceProtocol to implement the method
extension NetworkServiceProtocol {
    func execute<T: Decodable>(_ urlRequest: URLRequestBuilder,completion: @escaping (Result<T, ServiceError>, Int?) -> Void) {
        
        AF.request(urlRequest)
            .responseData { (response: DataResponse<Data, AFError>) in
                switch response.result {
                case .success(let data):
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let successResponse = try decoder.decode(SuccessResponse<T>.self, from: data)
                        completion(.success(successResponse.data), response.response?.statusCode)
                    } catch {
                        do {
                            let failureResponse = try JSONDecoder().decode(FailureResponse.self, from: data)
                            
                                completion(.failure(.serverError(message: failureResponse.message)), response.response?.statusCode)
                            
                        } catch {
                            completion(.failure(.serverError(message: error.localizedDescription)), response.response?.statusCode)
                        }
                    }
                case .failure(let error):
                    print(error.failureReason)
                    completion(.failure(.serverError(message: error.localizedDescription)), response.response?.statusCode)
                }
            }
            
    }
}

public class NetworkService: NetworkServiceProtocol {
    static let `default`: NetworkServiceProtocol = {
        var service = NetworkService()
        return service
    }()
}
