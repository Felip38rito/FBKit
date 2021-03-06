//
//  FBNibable.swift
//  FBKit
//
//  Created by Felipe Correia on 04/03/20.
//  Copyright © 2020 Felip38rito. All rights reserved.
//

import UIKit

/// This great solution is fully based on this thread: https://stackoverflow.com/posts/53937885/revisions


/// Any component who can be loaded from a NIB.
/// The idea is to be able to create UIView based components from nib's ensuring the reusability
public protocol FBComponent {
    /// Name of the nib for this component
    static func nibName() -> String
}

public extension FBComponent {
    /// Defaults to name of the class
    static func nibName() -> String {
        return String(describing: self)
    }
}

/// When the component is UIView based
public extension FBComponent where Self: UIView {
    /// Safe load a view from nib as an optional
    static func fromNib() -> Self? {
        let bundle = Bundle(for: self)
        if let nib = bundle.loadNibNamed(nibName(), owner: self, options: nil) {
            if let result = nib.first as? Self {
                return result
            }
        }
        
        return nil
    }
}
