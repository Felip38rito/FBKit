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
    public var regex: String = "\\([0-9]{2}\\) ?([0-9])? ([0-9]{4})\\-([0-9]{4})"
}
