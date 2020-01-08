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
    init(list: [[ViewModel]], sections: [SectionViewModel], tableView: UITableView) {
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
        vm.prepareView(view: tableView.dequeueReusableCell(withIdentifier: vm.identifier, for: IndexPath(row: 0, section: section)))
        
        return vm.view
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listData[section].count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let vm = listData[indexPath.section][indexPath.row]
        
        vm.prepareView(view: tableView.dequeueReusableCell(withIdentifier: vm.identifier, for: indexPath))
        
        return vm.view as! UITableViewCell
    }
    
    // @todo: Implement filter functionality
}
