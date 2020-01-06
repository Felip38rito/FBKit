//
//  FBViewModelTest.swift
//  FBKitTests
//
//  Created by Felipe Correia on 06/01/20.
//  Copyright © 2020 Felip38rito. All rights reserved.
//

import XCTest
@testable import FBKit

class FBViewModelTest: XCTestCase {
    fileprivate var testView: TestView!
    fileprivate var testModel: TestModel!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.testView = TestView()
        self.testView.createLabelHelper(text: "Some label helper")
        self.testModel = TestModel(textState: "Initial model data")
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
//        self.testModel = TestModel(textState: "Different value from view")
//        self.testView.createLabelHelper(text: "Different value from model")
    }

    func testViewModelStructBinding() {
        var viewModel = TestViewModel(model: self.testModel, view: self.testView)
        /// A inicializacao nao preserva a troca no init com didSet
        XCTAssertNotEqual(testModel.textState, testView.label.text)
        
        /// Mas preserva a troca de state no set
        self.testModel = TestModel(textState: "Some model data")
        viewModel.model = self.testModel
        
        XCTAssertEqual(viewModel.view.label?.text, viewModel.model.textState)
    }
    
    func testViewModelInitBinding() {
        /// Mas podemos usar um update view helper pra atingir esse objeto em classes ou structs com init...
        var viewModel = TestViewModelClass(model: self.testModel, view: self.testView)
        XCTAssertEqual(testView.label.text, testModel.textState)
        
        testModel = TestModel(textState: "Another")
        viewModel.model = testModel
//        viewModel.model = TestModel(textState: "Another")
        XCTAssertEqual(viewModel.view, testView)
        XCTAssertEqual(viewModel.model, testModel)
        XCTAssertEqual(testModel.textState, testView.label.text)
        
    }
}

fileprivate struct TestModel: FBModel {
    let textState: String
}

fileprivate class TestView: UIView {
    var label: UILabel!
    
    func createLabelHelper(text: String) {
        let lbl = UILabel()
        lbl.text = text
        self.label = lbl
    }
}

fileprivate struct TestViewModel: FBViewModel {
    typealias Model = TestModel
    typealias View = TestView
    
    var model: TestModel {
        didSet {
            view.label.text = model.textState
        }
    }
    var view: TestView
}

fileprivate struct TestViewModelClass: FBViewModel {
    typealias Model = TestModel
    typealias View = TestView
    
    var view: TestView
    var model: TestModel {
        didSet {
            self.updateView()
        }
    }
    
    func updateView() {
        view.label.text = model.textState
    }
    
    init(model: TestModel, view: TestView) {
        self.model = model
        self.view = view
        self.updateView()
    }
}
