//
//  FBSimpleTableView.swift
//  FBKit
//
//  Created by Felipe Correia on 05/01/20.
//  Copyright © 2020 Felip38rito. All rights reserved.
//

import UIKit

open class FBSimpleTableView<ViewModel: FBCellViewModel>: NSObject, UITableViewDelegate, UITableViewDataSource {
    /// The basic FB View Model for a MVVM strategy
    private var listData = [ViewModel]()
    private var filteredData = [ViewModel]()
    /// The tableview object to be delegated
    private weak var tableView: UITableView!
    
    /// The delegate responsible to catch index visibility (for use in pagination for example)
    public var indexDelegate: FBIndexDelegate?
    
    /// Create a UITableView with the MVVM strategy
    /// - Parameter list: A list of ViewModels to be rendered as rows
    /// - Parameter tableView: A UITableView instance to be filled
    public init(list: [ViewModel], tableView: UITableView) {
        super.init()

        self.listData = list
        self.filteredData = list
        self.tableView = tableView
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    /// Add rows to UITableView
    /// - Parameter itemsToAdd: A list of aditional items to be added
    public func add(_ items: [ViewModel]) {
        /// Prepara os indexPaths
        var i = listData.count - 1
        let indexPaths = items.map { (viewModel) -> IndexPath in
            i += 1
            return IndexPath(row: i, section: 0)
        }
        
        // Atualiza o modelo
        listData += items
        
        // Soft add na view
        self.tableView.beginUpdates()
        self.tableView.insertRows(at: indexPaths, with: .automatic)
        self.tableView.endUpdates()
    }
    
    // MARK: - Delegate and DataSource methods
    /// We'll only have a single section
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    /// For each ViewModel in our collection we'll generate a single view row
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = filteredData[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.identifier) {
            return viewModel.prepareView(view: cell) as! UITableViewCell
        }
         
        return UITableViewCell()
    }
    
    /// When the tableview display the index
    open func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        indexDelegate?.willReachIndex(index: indexPath)
    }
    
    /// Setting up the height for the row
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return filteredData[indexPath.row].viewSize.height
    }
    
    /// A simple table view will have only one section
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    /// Filter data to match some generic condition
    public func filter(success: @escaping ((_ vm: ViewModel) -> Bool)) {
        self.filteredData = self.listData.filter(success)
        self.tableView.reloadData()
    }
    
    /// Get a single component by it's indexPath
    public func get(indexPath: IndexPath /*, filtered: Bool = true */) -> ViewModel {
        /// Since the
//        let vm = (filtered) ? filteredData[indexPath.row] : listData[indexPath.row]
        var vm = filteredData[indexPath.row]
        
        if let cell = self.tableView.dequeueReusableCell(withIdentifier: vm.identifier) {
            vm.view = vm.prepareView(view: cell)
        }
        
        return vm
    }
    
    /// I've noticed that I can't run this method by extending FBSimpleTableView and then implementing
    /// although that class would be the delegate. So, i just pass through and let the implementation
    /// extend this method if needed
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    open func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
    }
}
