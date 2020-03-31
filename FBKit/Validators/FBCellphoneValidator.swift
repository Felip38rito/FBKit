//
//  FBCellphoneValidator.swift
//  FBKit
//
//  Created by Felipe Correia on 31/03/20.
//  Copyright © 2020 Felip38rito. All rights reserved.
//

import Foundation

/// Brazilian cellphone validator
public class FBCellphoneValidator: FBRegexValidator {
    public var regex: String {
        get {
            let ddd = "\\([0-9]{2}\\)"
            let body = "[0-9]{4,5}"
            let end  = "[0-9]{4}"
            
            return "\(ddd) \(body)-\(end)"
        }
    }
    
    public init() { }
}
