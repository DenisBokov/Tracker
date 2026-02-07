//
//  UserDefautsServices.swift
//  Tracker
//
//  Created by Denis Bokov on 05.02.2026.
//

import Foundation

enum UserDefaultsKey: String {
    case hasSeenOnboarding
}

class UserDefaultsServices {
    private let userDefaults: UserDefaults

    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }

    func set(_ value: Bool, for key: UserDefaultsKey) {
        userDefaults.set(value, forKey: key.rawValue)
    }

    func bool(for key: UserDefaultsKey) -> Bool {
        userDefaults.bool(forKey: key.rawValue)
    }
}
