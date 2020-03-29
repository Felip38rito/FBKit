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
            let firstPart = "[A-Z0-9a-z]([A-Z0-9a-z._%+-]{0,30}[A-Z0-9a-z])?"
            /// O servidor tem um formato especifico
            let serverPart = "([A-Z0-9a-z]([A-Z0-9a-z-]{0,30}[A-Z0-9a-z])?\\.){1,5}"
            /// O final do email vai de 2 a 8 caracteres (por garantia, a maioria termina em .com)
            let end = "[A-Za-z]{2,8}"
    
            return "\(firstPart)@\(serverPart)\(end)"
        }
    }
}
