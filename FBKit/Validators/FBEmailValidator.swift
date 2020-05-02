//
//  FBEmailValidator.swift
//  Alamofire
//
//  Created by Felipe Correia on 29/03/20.
//

import Foundation

public class FBEmailValidator: FBRegexValidator {
    public init() {
        let regex: String = {
            return "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        }()
        
        super.init(regex)
    }
    
    public override func isValid(_ text: String) -> Bool {
        super.isValid(text.trimmingCharacters(in: CharacterSet(charactersIn: " ")))
    }
}
