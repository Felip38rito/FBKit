//
//  FBButton.swift
//  FBKit
//
//  Created by Felipe Correia on 05/01/20.
//  Copyright © 2020 Felip38rito. All rights reserved.
//

import UIKit

@IBDesignable public class FBButton: UIButton {
    let gradientBackgroundLayer = CAGradientLayer()
    let gradientBorderLayer = CAGradientLayer()
    let shapeBackgroundLayer = CAShapeLayer()
    let shapeBorderLayer = CAShapeLayer()
    
    // MARK: - Global Properties
    @IBInspectable public var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = self.cornerRadius
        }
    }
//
//    @IBInspectable public var borderWidth : CGFloat = 0.0 {
//        didSet {
//            self.borderLayer.borderWidth = self.borderWidth
//        }
//    }
//
    @IBInspectable public var isReversed: Bool = false {
        didSet {
            updateView()
        }
    }
//
    // MARK: - Gradient
    @IBInspectable public var firstColor: UIColor = UIColor.clear {
        didSet {
            updateView()
        }
    }

    @IBInspectable public var secondColor: UIColor = UIColor.clear {
        didSet {
            updateView()
        }
    }
//
//    @IBInspectable public var borderColor : UIColor? {
//        didSet {
//            self.layer.borderColor = self.borderColor?.cgColor
//        }
//    }
//
//    /// Change the visual scale of the Button, with defaults to 1.0 (no scale transform)
//    @IBInspectable public var fixedScale : CGFloat = 1.0 {
//        didSet {
//            self.transform = CGAffineTransform.identity.scaledBy(x: self.fixedScale, y: self.fixedScale)
//        }
//    }
//
//    /// The default layer for the buttons is the layer of gradient backgrounds
//    public override class var layerClass: AnyClass {
//        return CAGradientLayer.self
//    }
//
//    /// The border separated layer
//    public var borderLayer: CALayer {
//        if isReversed {
//
//        } else {
//
//        }
//
//        return self.layer
//    }
//
//    /// Update the visual when some var is setted
    internal func updateView() {
        /// If it's added
        gradientBackgroundLayer.removeFromSuperlayer()
        gradientBorderLayer.removeFromSuperlayer()
        shapeBackgroundLayer.removeFromSuperlayer()
        shapeBorderLayer.removeFromSuperlayer()
        
        if isReversed {
            self.layer.backgroundColor = UIColor.clear.cgColor
            
            gradientBorderLayer.frame = self.bounds
            gradientBackgroundLayer.frame = self.bounds
            
            gradientBorderLayer.cornerRadius = self.cornerRadius
            gradientBackgroundLayer.cornerRadius = self.cornerRadius
            
            gradientBorderLayer.colors = [self.firstColor, self.secondColor]
            gradientBackgroundLayer.colors = [self.backgroundColor ?? UIColor.clear]
            
        } else {
            gradientBackgroundLayer.colors = [self.firstColor, self.secondColor]
            gradientBackgroundLayer.cornerRadius = self.cornerRadius
        }
        
        self.layer.insertSublayer(gradientBorderLayer, at: 0)
        self.layer.insertSublayer(gradientBackgroundLayer, at: 1)
    }
}
