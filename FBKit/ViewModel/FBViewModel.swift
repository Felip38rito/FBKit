//
//  FBViewModel.swift
//  FBKit
//
//  Created by Felipe Correia on 04/01/20.
//  Copyright © 2020 Felip38rito. All rights reserved.

import UIKit
/// FBKit View Models::Represents the ViewModel layer in a MVVM strategy
/// View Models are meant to be the binder between Models and Views.
public protocol FBViewModel {
    /// FBKit View Models are always linked to a single FBKit Model
    associatedtype Model: FBModel
    /// FBKit View layer for this ViewModel. They will always inherit UIView from UIKit
    associatedtype View: UIView
    /// ViewModel model instance as a readonly property
    var model: Model { set get }
    /// ViewModel view instance as a readonly property
    var view: View { set get }
}
