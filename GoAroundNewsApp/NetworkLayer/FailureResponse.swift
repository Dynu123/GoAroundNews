//
//  FailureResponse.swift
//  GoAroundNewsApp
//
//  Created by Dyana Varghese on 08/12/22.
//

import Foundation

struct FailureResponse: Decodable {
    let code: String
    let message: String
}
