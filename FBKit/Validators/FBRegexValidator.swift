//
//  FBValidator.swift
//  Alamofire
//
//  Created by Felipe Correia on 29/03/20.
//

import Foundation

/// Default Regular Expression Validator
public protocol FBRegexValidator {
    var regex: String { get }
    func isValid(_ text: String) -> Bool
}

public extension FBRegexValidator {
    func isValid(_ text: String) -> Bool {
        do {
            let regexTest = try NSRegularExpression(pattern: regex, options: .caseInsensitive)
            return regexTest.firstMatch(in: text, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, text.count)) != nil
        
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
}
