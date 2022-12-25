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
    case getTopNews(country: NewsCountry, category: NewsCategory)
    case getNewsOnSearch(text: String)
    case updateProfile
    case changePassword(query: UpdatePasswordQuery)
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
            return "/news/\(country.rawValue)/\(category.rawValue)"
        case .getNewsOnSearch(let text):
            return "/news/search/\(text)"
        case .updateProfile:
            return "/user/update"
        case .changePassword:
            return "/user/changepassword"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .login(let credential):
            return ["email": credential.email, "password": credential.password]
        case .signup(let credential):
            return ["email": credential.email, "name": credential.name, "phone": credential.phone, "confirmPassword": credential.confirmPassword, "password": credential.password]
        case .changePassword(let query):
            return ["id": LocalStorage.user?.id ?? 0, "currentpassword": query.currentPassword, "newpassword": query.newPassword, "confirmpassword": query.confirmPassword]
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
        case .updateProfile, .changePassword:
            return .put
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
        case .login, .signup:
            return nil
        default:
            return ["Authorization": "Bearer \(LocalStorage.user?.token ?? "")"]
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

struct UpdatePasswordQuery {
    var currentPassword: String
    var newPassword: String
    var confirmPassword: String
}
