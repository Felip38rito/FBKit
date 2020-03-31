//
//  FBRequiredValidator.swift
//  FBKit
//
//  Created by Felipe Correia on 31/03/20.
//  Copyright © 2020 Felip38rito. All rights reserved.
//

import Foundation

/// Garante que nao seja um texto vazio, ou apenas com espaços
public class FBRequiredValidator: FBValidator {
    public func isValid(_ text: String) -> Bool {
        return text.replacingOccurrences(of: " ", with: "") != ""
    }
    
    public init() {
        
    }
}
