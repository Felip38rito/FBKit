//
//  FBSectionTableView.swift
//  FBKit
//
//  Created by Felipe Correia on 05/01/20.
//  Copyright © 2020 Felip38rito. All rights reserved.
//

import UIKit

@available(iOS 11.0, *)
open class FBSectionTableView<ViewModel: FBCellViewModel, SectionViewModel: FBCellViewModel>: NSObject, UITableViewDelegate, UITableViewDataSource {
    private weak var tableView: UITableView!
    private var listData = [[ViewModel]]()
    private var sectionData = [SectionViewModel]()
    
    public var leadingActions: UISwipeActionsConfiguration?
    public var trailingActions: UISwipeActionsConfiguration?
    
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
    
    /// Remove a single item by its indexPath
    public func remove(at indexPath: IndexPath) {
        /// Caso haja somente um item nesta section vamos apagar a section toda
        if listData[indexPath.section].count == 1 {
            listData.remove(at: indexPath.section)
            sectionData.remove(at: indexPath.section)
            tableView.deleteSections(IndexSet(integer: indexPath.section), with: .automatic)
        } else {
            listData[indexPath.section].remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    /// I've noticed that I can't run this method by extending FBSimpleTableView and then implementing
    /// although that class would be the delegate. So, i just pass through and let the implementation
    /// extend this method if needed
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { }
    
    open func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) { }
    
    /// For the case of leading and trailing action configurations, we'll use a property to set these actions
    /// So we can change them like before. Initializing
    open func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return leadingActions
    }
    
    open func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return trailingActions
    }
}
