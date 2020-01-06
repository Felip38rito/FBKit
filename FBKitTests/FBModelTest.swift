//
//  FBModelTest.swift
//  FBKitTests
//
//  Created by Felipe Correia on 06/01/20.
//  Copyright © 2020 Felip38rito. All rights reserved.
//

import XCTest
@testable import FBKit

class FBModelTest: XCTestCase {
    fileprivate var testModel: TestModel?
    fileprivate var testModelList: TestModelList?
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.testModel = TestModel(name: "Felipe", number: 28.1, bool: true, integer: 1)
        self.testModelList = TestModelList(list: [self.testModel!])
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testModelParse() {
        XCTAssert(self.testModel?.JSON.contains("\"name\":\"Felipe\"") ?? false, "Nome encontrado")
        XCTAssert(self.testModel?.JSON.contains("\"number\":28.1") ?? false, "Numero encontrado")
        XCTAssert(self.testModel?.JSON.contains("\"bool\":true") ?? false, "Bool tipado corretamente")
        XCTAssert(self.testModel?.JSON.contains("\"integer\":1") ?? false, "Inteiro tipado")
        
        XCTAssert(self.testModelList?.JSON.contains("{\"list\":[") ?? false, "Inicio correto")
        XCTAssert(self.testModelList?.JSON.contains("\"name\":\"Felipe\"") ?? false, "Nome encontrado")
        XCTAssert(self.testModelList?.JSON.contains("\"number\":28.1") ?? false, "Numero encontrado")
        XCTAssert(self.testModelList?.JSON.contains("\"bool\":true") ?? false, "Bool tipado corretamente")
        XCTAssert(self.testModelList?.JSON.contains("\"integer\":1") ?? false, "Inteiro tipado")
    }
}

fileprivate struct TestModel: FBModel {
    let name: String
    let number: Double
    let bool: Bool
    let integer: Int
}

fileprivate struct TestModelList: FBModel {
    let list: [TestModel]
}
