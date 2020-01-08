//
//  Model.swift
//  FBKit
//
//  Created by Felipe Correia on 04/01/20.
//  Copyright © 2020 Felip38rito. All rights reserved.
//

import Foundation
/// FBKit Model:: Structs for Model layer
/// Represents the Model layer in MVC and MVVM patterns.
/// The FBKit models can always be translated to JSON thanks to Codable feature
public protocol FBModel: Codable, Equatable {
    /// JSON string representation of the Model
    var JSON: String { get }
}

public extension FBModel {
    fileprivate var jsonData: Data {
        get {
            let encoder = JSONEncoder()
            
            do {
                return try encoder.encode(self)
            } catch {
                print(error.localizedDescription)
                return Data()
            }
        }
    }
    // Default JSON model implementation to all FBKit Model structs... :)
    var JSON: String {
        get {
            return String(data: self.jsonData, encoding: .utf8) ?? ""
        }
    }
    
    // Default Equatable structure
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.JSON == rhs.JSON
    }
}
