//
//  FBKeyboardDelegate.swift
//  machine2air
//
//  Created by Felipe Correia on 28/03/20.
//  Copyright © 2020 Machine Air. All rights reserved.
//

import UIKit

/// FBKeyboardDelegate can inform you when the keyboard will show up and when it will disappear
/// it also inform the rect of the keyboard in it's methods
public protocol FBKeyboardDelegate {
    func keyboardWillAppear(with height: CGFloat)
    func keyboardWillDisappear()
}

public class FBKeyboardObserver {
    var delegate: FBKeyboardDelegate
    
    public init(delegate: FBKeyboardDelegate) {
        self.delegate = delegate
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDisappear), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc internal func keyboardAppear(_ notification: NSNotification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        delegate.keyboardWillAppear(with: keyboardFrame.cgRectValue.height)
    }
    
    @objc internal func keyboardDisappear(_ notification: NSNotification) {
        delegate.keyboardWillDisappear()
    }
}

public extension UIViewController {
    /// Snippet para esconder o teclado ao tocar em qualquer area do viewcontroller
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = true
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
