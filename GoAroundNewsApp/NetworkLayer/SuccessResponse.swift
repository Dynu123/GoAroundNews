//
//  SuccessResponse.swift
//  GoAroundNewsApp
//
//  Created by Dyana Varghese on 08/12/22.
//

import Foundation

struct SuccessResponse<T: Codable>: Codable {
    let code: String
    let message: String
    let data: T
}
