//
//  LinkbuilderTestss.swift
//  LinkbuilderTestss
//
//  Created by Axxiome Health on 18/10/2022.
//

import XCTest
@testable import linkbuilder
final class LinkbuilderTestss: XCTestCase {
    var selection: SelectionViewModel!
    override func setUp() {
        super.setUp()
        selection = SelectionViewModel()
    }

    override func tearDown() {
        selection = nil
        super.tearDown()
    }
    func testChangeAfterPicking() {
        selection.changeAfterPickingSomething()
        XCTAssertNil(selection.useCase)
//        selection.selectedLink = .insurance
//        XCTAssertNil(selection.testCase)
    }
}
