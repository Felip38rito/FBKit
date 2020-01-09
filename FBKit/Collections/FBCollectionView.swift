//
//  FBCollectionView.swift
//  FBKit
//
//  Created by Felipe Correia on 05/01/20.
//  Copyright © 2020 Felip38rito. All rights reserved.
//

import UIKit

open class FBCollectionView<ViewModel: FBCellViewModel>: NSObject, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    
    private weak var collectionView: UICollectionView!
    internal var original_components_list = [ViewModel]()
    internal var filtered_components_list = [ViewModel]()
    
    /// The delegate responsible to catch index visibility (for use in pagination for example)
    public var indexDelegate: FBIndexDelegate?
    
    /// Create a UICollectionView with MVVM strategy
    /// - Parameter viewModelList: A FBCellViewModel list to be translated into UICollectionViewCell's Models
    /// - Parameter collectionView: An UICollectionView instance to be filled
    public init(list: [ViewModel], collectionView: UICollectionView) {
        super.init()
        
        original_components_list = list
        filtered_components_list = original_components_list
        
        self.collectionView = collectionView
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    // MARK: - DataSource and Delegate methods
    /// The items are inside listData
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filtered_components_list.count
    }
    
    /// Each row generated for collection view is based on viewmodel properties
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let vm = filtered_components_list[indexPath.row]
        vm.prepareView(view: collectionView.dequeueReusableCell(withReuseIdentifier: vm.identifier, for: indexPath))
        
        return vm.view as! UICollectionViewCell
    }
    
    /// The size of the cell component come from ViewModel
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return filtered_components_list[indexPath.row].viewSize
    }
    
    /// Expose the indexPath of the cell to be displayed
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        indexDelegate?.willReachIndex(index: indexPath)
    }
    
    // MARK: - Custom functionality
    /// Filter data to match some generic condition 
    public func filter(success: @escaping ((_ vm: ViewModel) -> Bool)) {
        self.filtered_components_list = original_components_list.filter(success)
        self.collectionView.reloadData()
    }
    
    /// Add new items to the UICollectionView
    public func add(_ items: [ViewModel]) {
        self.original_components_list += items
        self.filtered_components_list = original_components_list
        self.collectionView.reloadData()
    }
    
    /// Remove all the components
    public func clean() {
        original_components_list.removeAll()
    }
    
    // MARK: - Custom properties
    /// The list count when used filter (get all if no filter is in use)
    public var filtered_count: Int {
        get {
            return filtered_components_list.count
        }
    }
    
    /// The list object count regardless of filter
    public var list_count: Int {
        get {
            return original_components_list.count
        }
    }
}
