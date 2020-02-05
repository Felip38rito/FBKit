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
    let gradientBorderLayer = CAGradientLayer()
    let shapeBackgroundLayer = CAShapeLayer()
    let shapeBorderLayer = CAShapeLayer()
    
    // MARK: - Global Properties
    @IBInspectable public var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = self.cornerRadius
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
    
    /// Update the visual when some var is setted
    internal func updateView() {
        /// If it's added
        gradientBackgroundLayer.removeFromSuperlayer()
        gradientBorderLayer.removeFromSuperlayer()
        shapeBackgroundLayer.removeFromSuperlayer()
        shapeBorderLayer.removeFromSuperlayer()
        
        if isReversed {
//            self.layer.backgroundColor = UIColor.clear.cgColor
//
//            gradientBorderLayer.frame = self.bounds
//            gradientBackgroundLayer.frame = self.bounds
////
//            gradientBorderLayer.cornerRadius = self.cornerRadius
//            gradientBackgroundLayer.cornerRadius = self.cornerRadius
////
//            gradientBorderLayer.colors = [self.firstColor.cgColor, self.secondColor.cgColor]
//            gradientBackgroundLayer.colors = [self.backgroundColor?.cgColor ?? UIColor.clear.cgColor]
        }
        else {
//            gradientBorderLayer.frame = self.bounds
            gradientBackgroundLayer.frame = self.bounds
            
//            gradientBorderLayer.cornerRadius = self.cornerRadius
            gradientBackgroundLayer.cornerRadius = self.cornerRadius
            
            gradientBackgroundLayer.startPoint = self.gradientStart
            gradientBackgroundLayer.endPoint = self.gradientEnd
////
            gradientBackgroundLayer.colors = [self.firstColor.cgColor, self.secondColor.cgColor]
            
            self.layer.insertSublayer(gradientBackgroundLayer, at: 0)
        }
        
//        self.layer.insertSublayer(gradientBorderLayer, at: 0)
        
    }
}

