//
//  FBButton.swift
//  FBKit integration
//
//  Created by Felipe Correia on 05/02/20.
//  Copyright © 2020 Felip38rito. All rights reserved.
//

import UIKit

@IBDesignable public class FBButton: UIButton {
    let gradientBackgroundLayer = CAGradientLayer()
    let shapeBorderLayer = CAShapeLayer()
    
    // MARK: - Global Properties
    @IBInspectable public var cornerRadius: CGFloat = 0.0 {
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
    
    @IBInspectable public var reversedTextColor: UIColor = UIColor.black {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable public var textColor: UIColor = UIColor.black {
        didSet {
            updateView()
        }
    }

    @IBInspectable public var isReversed: Bool = false {
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
    
    /// The possibility to update the visual layers on update the constraints
    public override func updateConstraints() {
        super.updateConstraints()
        
        updateView()
    }
    
    /// Update the visual when some var is setted
    internal func updateView() {
        /// If it's added
        self.setTitleColor(self.textColor, for: .normal)
        gradientBackgroundLayer.removeFromSuperlayer()
        shapeBorderLayer.removeFromSuperlayer()
        
        /// Setup the gradient to be used
        gradientBackgroundLayer.frame = self.bounds
        gradientBackgroundLayer.cornerRadius = self.cornerRadius
        gradientBackgroundLayer.startPoint = self.gradientStart
        gradientBackgroundLayer.endPoint = self.gradientEnd
        gradientBackgroundLayer.colors = [self.firstColor.cgColor, self.secondColor.cgColor]
        
        if isReversed {
            /// Make the gradient to the border
            self.setTitleColor(self.reversedTextColor, for: .normal)
            
            shapeBorderLayer.frame = self.bounds
            shapeBorderLayer.lineWidth = self.borderWidth
            shapeBorderLayer.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.cornerRadius).cgPath
            shapeBorderLayer.fillColor = nil
            shapeBorderLayer.strokeColor = UIColor.black.cgColor
            
            gradientBackgroundLayer.mask = shapeBorderLayer
        }
        
        self.layer.insertSublayer(gradientBackgroundLayer, at: 0)
    }
}
