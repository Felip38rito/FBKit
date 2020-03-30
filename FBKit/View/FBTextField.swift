//
//  FBTextField.swift
//  FBKit
//
//  Created by Felipe Correia on 28/03/20.
//  Copyright © 2020 Felip38rito. All rights reserved.
//

import UIKit

// prototipo da classe FBTextField
@IBDesignable open class FBTextField: JMMaskTextField {
    
    internal var padding: UIEdgeInsets {
        get {
            return UIEdgeInsets(top: 0, left: textInset, bottom: 0, right: textInset)
        }
    }

    @IBInspectable public var textInset: CGFloat = 5.0 {
        
        didSet {
            setNeedsLayout()
            updateView()
        }
    }
    
    @IBInspectable public var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = self.cornerRadius
            setNeedsLayout()
            updateView()
        }
    }
    
    @IBInspectable public var borderWidth: CGFloat = 0.0 {
        didSet {
            self.layer.borderWidth = self.borderWidth
            setNeedsLayout()
            updateView()
        }
    }
    
    @IBInspectable public var borderColor: UIColor = UIColor.darkGray {
        didSet {
            self.layer.borderColor = self.borderColor.cgColor
            setNeedsLayout()
            updateView()
        }
    }
    
    @IBInspectable public var placeholderColor: UIColor = UIColor.darkGray {
        didSet {
            self.setPlaceholderColor(self.placeholderColor)
            setNeedsLayout()
            updateView()
        }
    }
    
    /// stay text inset
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    /// Placeholder inset
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    /// Edit inset
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    public func updateView() {
        self.borderStyle = .none
        self.clipsToBounds = true
    }
}

public extension UITextField {
    /// Change placeholder color in any UITextField. Cortesy of FBKit :)
    func setPlaceholderColor(_ color: UIColor) {
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor: color])
    }
}

