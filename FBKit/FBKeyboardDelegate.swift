//
//  FBKeyboardDelegate.swift
//  machine2air
//
//  Created by Felipe Correia on 28/03/20.
//  Copyright © 2020 Machine Air. All rights reserved.
//

import UIKit

public protocol FBKeyboardDelegate {
    func keyboardWillAppear()
    func keyboardWillDisappear()
}

public class FBKeyboardObserver {
    var delegate: FBKeyboardDelegate
    
    public init(delegate: FBKeyboardDelegate) {
        self.delegate = delegate
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDisappear), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc internal func keyboardAppear() {
        delegate.keyboardWillAppear()
    }
    
    @objc internal func keyboardDisappear() {
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
