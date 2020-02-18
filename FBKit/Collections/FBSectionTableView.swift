//
//  FBSectionTableView.swift
//  FBKit
//
//  Created by Felipe Correia on 05/01/20.
//  Copyright © 2020 Felip38rito. All rights reserved.
//

import UIKit

open class FBSectionTableView<ViewModel: FBCellViewModel, SectionViewModel: FBCellViewModel>: NSObject, UITableViewDelegate, UITableViewDataSource {
    private weak var tableView: UITableView!
    private var listData = [[ViewModel]]()
    private var sectionData = [SectionViewModel]()
    
    /// Create a section enabled UITableView with the MVVM strategy
    /// - Parameter list: A list of ViewModels to be rendered as rows
    public init(list: [[ViewModel]], sections: [SectionViewModel], tableView: UITableView) {
        super.init()

        self.listData = list
        self.sectionData = sections
        self.tableView = tableView
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    // MARK: - DataSource and Delegate methods
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return listData.count
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let vm = sectionData[section]
        
        return vm.prepareView(view: tableView.dequeueReusableCell(withIdentifier: vm.identifier, for: IndexPath(row: 0, section: section))) as UIView
    }
    
    /// Height for the headers
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let vm = sectionData[section]
        return vm.viewSize.height
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listData[section].count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let vm = listData[indexPath.section][indexPath.row]
        
        return vm.prepareView(view: tableView.dequeueReusableCell(withIdentifier: vm.identifier, for: indexPath)) as! UITableViewCell
    }
    
    /// Get a single component by it's indexPath
    public func get(indexPath: IndexPath) -> ViewModel {
        return listData[indexPath.section][indexPath.row]
    }
    
    /// I've noticed that I can't run this method by extending FBSimpleTableView and then implementing
    /// although that class would be the delegate. So, i just pass through and let the implementation
    /// extend this method if needed
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { }
    
    open func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) { }
    
    open func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool { return false }
    
    // @todo: Implement filter functionality
    @available(iOS 11.0, *)
    open func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? { return nil }
}
