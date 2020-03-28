//
//  FBTableViewCell.swift
//  FBKit
//
//  Created by Felipe Correia on 23/03/20.
//  Copyright © 2020 Felip38rito. All rights reserved.
//

import Foundation
//
//
//protocol FBTableViewCell {
//    associatedtype Model: FBModel
//    
//    var size: CGSize { get }
//    var viewModel: Model { get set }
//    
//    static func create(from: UITableViewCell, with model: Model) -> UITableViewCell
//}
//
//// abstract
//class ViewCell1: UITableViewCell, FBTableViewCell {
//    var viewModel: TableModel = TableModel(cellData: "a")
//    typealias Model = TableModel
//    
//    var size: CGSize = CGSize(width: 100, height: 100)
//    
//    static func create(from: UITableViewCell, with model: TableModel) -> UITableViewCell {
//        guard let container = from as? ViewCell1 else { return ViewCell1() }
//        
//        return container
//    }
//}
//
//class ViewCell2: UITableViewCell, FBTableViewCell {
//    typealias Model = TableModel
//    var viewModel: TableModel = TableModel(cellData: "a")
//    var size: CGSize = CGSize(width: 20, height: 300)
//    
//    static func create(from: UITableViewCell, with model: TableModel) -> UITableViewCell {
//        guard let container = from as? ViewCell2 else { return ViewCell2() }
//        
//        return container
//    }
//}
//
//struct TableModel: FBModel {
//    let cellData: String
//}
