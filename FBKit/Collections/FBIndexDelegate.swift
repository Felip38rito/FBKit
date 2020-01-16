//
//  FBIndexDelegate.swift
//  FBKit
//
//  Created by Felipe Correia on 08/01/20.
//  Copyright © 2020 Felip38rito. All rights reserved.
//

import Foundation

public protocol FBIndexDelegate {
    /// Will reach the indexpath in the collection
    /// - Parameter index: Represents the indexPath of a current list item being reached
    func willReachIndex(index: IndexPath)
}
