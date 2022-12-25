//
//  DeviceStorage.swift
//  GoAroundNewsApp
//
//  Created by Dyana Varghese on 09/12/22.
//

import Foundation

class LocalStorage {
    static var user: User? {
        get {
            return UserDefaults.standard.readObject(dataType: User.self, key: .userKey)
        }
        set {
            UserDefaults.standard.setObject(newValue, forKey: .userKey)
        }
    }
    
    static var selectedCountry: NewsCountry? {
        get {
            return UserDefaults.standard.readObject(dataType: NewsCountry.self, key: "country")
        }
        set {
            UserDefaults.standard.setObject(newValue, forKey: "country")
        }
    }
}

extension UserDefaults {
    func setObject<T: Codable>(_ data: T?, forKey defaultName: String) {
        let encoded = try? JSONEncoder().encode(data)
        set(encoded, forKey: defaultName)
    }
    
    func readObject<T : Codable>(dataType: T.Type, key: String) -> T? {
        guard let userDefaultData = data(forKey: key) else {
            return nil
        }
        return try? JSONDecoder().decode(T.self, from: userDefaultData)
    }
}




