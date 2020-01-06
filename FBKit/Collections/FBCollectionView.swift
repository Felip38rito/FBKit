//
//  FBCollectionView.swift
//  FBKit
//
//  Created by Felipe Correia on 05/01/20.
//  Copyright © 2020 Felip38rito. All rights reserved.
//

import UIKit

public class FBCollectionView<ViewModel: FBCellViewModel>: NSObject, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    
    private weak var collectionView: UICollectionView!
    private var listData = [ViewModel]()
    private var filteredData = [ViewModel]()
    
    /// Create a UICollectionView with MVVM strategy
    /// - Parameter viewModelList: A FBCellViewModel list to be translated into UICollectionViewCell's Models
    /// - Parameter collectionView: An UICollectionView instance to be filled
    public init(list: [ViewModel], collectionView: UICollectionView) {
        super.init()
        
        listData = list
        filteredData = listData
        
        self.collectionView = collectionView
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    /// Add new items to the UICollectionView
    public func add(_ items: [ViewModel]) {
        self.listData += items
        self.filteredData = listData
        self.collectionView.reloadData()
    }
    
    // MARK: - DataSource and Delegate methods
    /// The items are inside listData
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    /// Each row generated for collection view is based on viewmodel properties
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let vm = filteredData[indexPath.row]
        vm.prepareView(view: collectionView.dequeueReusableCell(withReuseIdentifier: vm.identifier, for: indexPath))
        
        return vm.view as! UICollectionViewCell
    }
    
    /// The size of the cell component come from ViewModel
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return filteredData[indexPath.row].viewSize
    }
    
    /// Filter data to match some generic condition 
    public func filter(success: @escaping ((_ vm: ViewModel) -> Bool)) {
        self.filteredData = listData.filter(success)
        self.collectionView.reloadData()
    }
}
