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
@IBDesignable public class FBView: UIView {
    
    @IBInspectable public var cornerRadius : CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    /// First color for the gradient background
    @IBInspectable public var gradientFirstColor: UIColor = UIColor.clear {
        didSet {
            updateView()
        }
    }
    
    /// Second color for gradient background
    @IBInspectable public var gradientSecondColor: UIColor = UIColor.clear {
        didSet {
            updateView()
        }
    }
    
    /// Define if the gradient either horizontal or vertical
    @IBInspectable public var gradientIsHorizontal: Bool = true {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable public var borderWidth: CGFloat = 0.0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable public var borderColor: UIColor = UIColor.clear {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    override public class var layerClass: AnyClass {
        get {
            return CAGradientLayer.self
        }
    }
    
    /// Update the properties
    private func updateView() {
        let layer = self.layer as! CAGradientLayer
        layer.colors = [gradientFirstColor, gradientSecondColor].map {$0.cgColor}
        if (gradientIsHorizontal) {
            layer.startPoint = CGPoint(x: 0, y: 0.5)
            layer.endPoint = CGPoint (x: 1, y: 0.5)
        } else {
            layer.startPoint = CGPoint(x: 0.5, y: 0)
            layer.endPoint = CGPoint (x: 0.5, y: 1)
        }
    }
}
