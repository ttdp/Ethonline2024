//
//  UserDefaulfs+Extension.swift
//  Wallet-iOS
//
//  Created by Tian Tong on 2024/8/24.
//

import Foundation

extension UserDefaults {
    
    func set<T: Codable>(object: T, for key: String) throws {
        let jsonData = try JSONEncoder().encode(object)
        set(jsonData, forKey: key)
    }
    
    func get<T: Codable>(objectType: T.Type, for key: String) throws -> T? {
        guard let jsonData = value(forKey: key) as? Data else {
            return nil
        }
        return try JSONDecoder().decode(objectType, from: jsonData)
    }
    
}
