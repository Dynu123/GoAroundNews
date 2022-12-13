//
//  API.swift
//  GoAroundNewsApp
//
//  Created by Dyana Varghese on 08/12/22.
//

import Foundation
import Alamofire

// MARK: - Create API enum conforming to URLRequestBuilder, add the api name
enum API: URLRequestBuilder {
    case login(credential: Credential)
    case signup(credential: Credential)
    case getTopNews(country: String, category: String)
    case getNewsOnSearch(text: String)
    case updateProfile
}

// MARK: - Extend API to implement the inputs
extension API {

    var path: String {
        switch self {
        case .login:
            return "/login"
        case .signup:
            return "/signup"
        case .getTopNews(let country, let category):
            return "/news/\(country)/\(category)"
        case .getNewsOnSearch(let text):
            return "/news/search/\(text)"
        case .updateProfile:
            return "/user/update"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .login(let credential):
            return ["email": credential.email, "password": credential.password]
        case .signup(let credential):
            return ["email": credential.email, "name": credential.name, "phone": credential.phone, "confirmPassword": credential.confirmPassword, "password": credential.password]
        default:
            return nil
        }
    }
        
    var method: HTTPMethod {
        switch self {
        case .login, .signup:
            return .post
        case .getTopNews, .getNewsOnSearch:
            return .get
        case .updateProfile:
            return .put
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
        case .login, .signup:
            return nil
        default:
            return ["Authorization": "Bearer token"]
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .login:
            return URLEncoding.default
        default:
            return JSONEncoding.default
        }
    }
    
}

