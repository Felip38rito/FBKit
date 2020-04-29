//
//  FBLabel.swift
//  FBKit
//
//  Created by Felipe Correia on 29/04/20.
//  Copyright © 2020 Felip38rito. All rights reserved.
//

import UIKit

@IBDesignable
open class FBLabel: UILabel {
    @IBInspectable
    var sizeForSe: CGFloat = 16.0 {
        didSet {
            if UIDevice.current.screenType == .iPhones_5_5s_5c_SE {
                self.font = UIFont(name: self.font.fontName, size: sizeForSe)
            }
        }
    }
}
