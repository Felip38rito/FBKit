//
//  FBCellViewModel.swift
//  FBKit
//
//  Created by Felipe Correia on 04/01/20.
//  Copyright © 2020 Felip38rito. All rights reserved.
//

import UIKit

public protocol FBIdentifiable {
    /**
     Interface builder identifier
     
     This property is meant to be used for ViewModels with autogenerated View layer from IB,
     so you can ignore it when constructing your views entirely from code.
     
     For FBCellViewModel cases, at least when in use inside FBKit collections like FBCollectionView and FBSimpleTableView for example, it's meant to match the interface builder id of the cell.
     */
    var identifier: String { get }
}

/// ViewModel for binding of cells (UICollectionViewCell or UITableViewCell for example)
public protocol FBCellViewModel: FBViewModel & FBIdentifiable {
    /// Create the view model from model instance
    init(model: Model)
    /**
     Prepare the view to bind with the model
     
     Since the cells in general are loaded from IB, we tried to separate it from init.
     In fact, the initialization of the FBViewModel objects will depend of its type, but for this case it's
     better to be able to receive a view independently and then cast in implementation.
     
     This way, we can create components like FBCollectionView and FBSimpleTableView from generic approach
     using either IB or custom code for ViewModels's visual layer
    */
    func prepareView(view: UIView) -> View
    
    /**
     Size of the view in ViewModel
     
     This property is meant to be used with IB loaded cells. For example, in a UICollectionView, you
     can specify collectionView(..:sizeForItemAt..) using this property.
     
     In fact, it's what we use in FBCollectionView when delegating an UICollectionView.
     For UITableView, in general, only the height will be considered.
     */
    var viewSize: CGSize { get }
}
