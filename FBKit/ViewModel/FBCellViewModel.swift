//
//  FBCellViewModel.swift
//  FBKit
//
//  Created by Felipe Correia on 04/01/20.
//  Copyright © 2020 Felip38rito. All rights reserved.
//

import UIKit


public protocol FBIdentifiable {
    /// Interface builder identifier
    /// For interface builder generated cell views, for example
    /// UICollectionViewCell or UITableViewCell instances generated directly from SB
    var identifier: String { get }
}

public protocol FBSizeable {
    /// Size for view embeded
    var viewSize: CGSize { get }
}

/// ViewModel for binding of cells (UICollectionViewCell or UITableViewCell for example)
public protocol FBCellViewModel: FBViewModel & FBIdentifiable & FBSizeable {
    /// Create the view model from model instance
    init(model: Model)
    /// Prepare the view loaded from interface builder
    func prepareView(view: UIView)
}
