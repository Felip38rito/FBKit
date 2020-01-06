//
//  FBButton.swift
//  FBKit
//
//  Created by Felipe Correia on 05/01/20.
//  Copyright © 2020 Felip38rito. All rights reserved.
//

import UIKit

@IBDesignable public class FBButton: UIButton {
    
    @IBInspectable public var cornerRadius : CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = self.cornerRadius
        }
    }

    @IBInspectable public var borderWidth : CGFloat = 0.0 {
        didSet {
            self.layer.borderWidth = self.borderWidth
        }
    }

    @IBInspectable public var borderColor : UIColor? {
        didSet {
            self.layer.borderColor = self.borderColor?.cgColor
        }
    }

    /// Change the visual scale of the Button, with defaults to 1.0 (no scale transform)
    @IBInspectable public var fixedScale : CGFloat = 1.0 {
        didSet {
            self.transform = CGAffineTransform.identity.scaledBy(x: self.fixedScale, y: self.fixedScale)
        }
    }
}

