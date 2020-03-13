//
//  FBView.swift
//  FBKit
//
//  Created by Felipe Correia on 05/01/20.
//  Copyright © 2020 Felip38rito. All rights reserved.
//

import UIKit

/// A simple UIView with some extra interface builder properties
/// to make the implementation easier
@IBDesignable open class FBView: UIView {
    /// The gradient in the background
    public let gradientBackgroundLayer = CAGradientLayer()
    /// The border as a shape to be able to change stroke behaviour
    public let shapeBorderLayer = CAShapeLayer()
    
    // MARK: - Global properties
    @IBInspectable public var cornerRadius : CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = self.cornerRadius
            updateView()
        }
    }
    
    @IBInspectable public var borderWidth: CGFloat = 0.0 {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable public var borderColor: UIColor = UIColor.clear {
        didSet {
            updateView()
        }
    }
    
    // MARK: - Dash items
    @IBInspectable public var dashWidth: CGFloat = 1.0 {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable public var dashSpacing: CGFloat = 0.0 {
        didSet {
            updateView()
        }
    }
    
    // MARK: - Shadow
    @IBInspectable public var shadowColor: UIColor = UIColor.clear {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable public var shadowSize: CGFloat = 0.0 {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable public var shadowOpacity: CGFloat = 1.0 {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable public var shadowOffset: CGSize = CGSize.zero {
        didSet {
            updateView()
        }
    }
    
    // MARK: - Gradient
    @IBInspectable public var gradientStart: CGPoint = CGPoint(x:0, y:0) {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable public var gradientEnd: CGPoint = CGPoint(x:0, y:0) {
        didSet {
            updateView()
        }
    }
    
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
    
    /// Update the visual changes
    public func updateView() {
        gradientBackgroundLayer.removeFromSuperlayer()
        shapeBorderLayer.removeFromSuperlayer()
        
        /// Setup the gradient to be used in background
        gradientBackgroundLayer.frame = self.bounds
        gradientBackgroundLayer.cornerRadius = self.cornerRadius
        gradientBackgroundLayer.startPoint = self.gradientStart
        gradientBackgroundLayer.endPoint = self.gradientEnd
        gradientBackgroundLayer.colors = [self.firstColor.cgColor, self.secondColor.cgColor]
        
        /// Setup the border
        shapeBorderLayer.frame = self.bounds
        shapeBorderLayer.lineWidth = self.borderWidth
        shapeBorderLayer.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.cornerRadius).cgPath
        
        shapeBorderLayer.fillColor = nil
        shapeBorderLayer.strokeColor = borderColor.cgColor
        
        shapeBorderLayer.lineDashPattern = [dashWidth, dashSpacing].map({ (value) -> NSNumber in
            return NSNumber(value: Float(value))
        })
        
        /// Setup the shadow
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.cornerRadius).cgPath
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowRadius = shadowSize
        
        if 0 <= shadowOpacity && shadowOpacity <= 1 {
            self.layer.shadowOpacity = Float(shadowOpacity)
        }
        
        self.layer.insertSublayer(gradientBackgroundLayer, at: 0)
        self.layer.insertSublayer(shapeBorderLayer, at: 1)
    }
}
