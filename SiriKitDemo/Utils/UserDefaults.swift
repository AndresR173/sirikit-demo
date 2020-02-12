//
//  UserDefaults.swift
//  SiriKitDemo
//
//  Created by Andres Rojas on 22/01/20.
//  Copyright © 2020 Andres Rojas. All rights reserved.
//

import Foundation

@propertyWrapper
struct UserDefaultsWrapper<Value: Codable> {
    let key: String
    let defaultValue: Value
    let userDefaults = UserDefaults(suiteName: Constants.kGroupIdentifier)

    var wrappedValue: Value {
        get {
            let data = userDefaults?.data(forKey: key)
            let value = data.flatMap { try? JSONDecoder().decode(Value.self, from: $0) }
            return value ?? defaultValue
        }

        set {
            let data = try? JSONEncoder().encode(newValue)
            userDefaults?.set(data, forKey: key)
            userDefaults?.synchronize()
        }
    }
}
