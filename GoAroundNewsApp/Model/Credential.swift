//
//  Credential.swift
//  GoAroundNewsApp
//
//  Created by Dyana Varghese on 08/12/22.
//

import Foundation

struct Credential: Codable {
    var phone: String = ""
    var name: String = ""
    var email: String = ""
    var password: String = ""
    var confirmPassword = ""
    
    // MARK: - Email validation using regex
    var isValidEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    var isValidPhone: Bool {
        let phoneRegex = "^[0-9]\\d{9}$"
        let phonePred = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phonePred.evaluate(with: phone)
    }
    
    var passwordsMatch: Bool {
        return password == confirmPassword
    }
}
