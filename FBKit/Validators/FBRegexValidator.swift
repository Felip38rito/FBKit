//
//  FBValidator.swift
//  Alamofire
//
//  Created by Felipe Correia on 29/03/20.
//

import Foundation

/// Default validator
public protocol FBValidator {
    func isValid(_ text: String) -> Bool
}

/// Default Regular Expression Validator
open class FBRegexValidator: FBValidator {
    open var regex: String
    
    open func isValid(_ text: String) -> Bool {
        do {
            let regexTest = try NSRegularExpression(pattern: regex)
            return regexTest.firstMatch(in: text, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, text.count)) != nil
        
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
    
    public init(_ regex: String) {
        self.regex = regex
    }
}
