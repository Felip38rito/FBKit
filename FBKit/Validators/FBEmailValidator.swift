//
//  FBEmailValidator.swift
//  Alamofire
//
//  Created by Felipe Correia on 29/03/20.
//

import Foundation

public class FBEmailValidator: FBRegexValidator {
    public var regex: String {
        get {
            
            return "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        }
    }
    
    public init() {
        
    }
}
