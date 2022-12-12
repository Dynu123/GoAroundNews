//
//  User.swift
//  GoAroundNewsApp
//
//  Created by Dyana Varghese on 08/12/22.
//

import Foundation



struct User: Codable {
    var id: Int
    var email: String
    var token: String
    var name: String
    var phone: String
}


extension User {
    static var sample: User {
        User(id: 1, email: "dyana@yopmail.com", token: "dfgdfhf", name: "Dyana", phone: "123456787")
    }
}
