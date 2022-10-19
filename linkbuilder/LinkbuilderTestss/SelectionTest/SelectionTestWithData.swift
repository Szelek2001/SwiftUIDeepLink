//
//  LinkbuilderTestss.swift
//  LinkbuilderTestss
//
//  Created by Axxiome Health on 18/10/2022.
//

import XCTest
@testable import linkbuilder
final class SelectionTestWithData: XCTestCase {
    var selection: SelectionViewModel!
    override func setUp() {
        super.setUp()
        selection = SelectionViewModel()
        UserDefaults.standard.set("config", forKey: Constant.keyForConfig)
        do { try
            selection.loadJson()
        } catch {}
    }

    override func tearDown() {
        selection = nil
        super.tearDown()
    }
    func testChangeAfterPicking() {
        selection.changeAfterPickingSomething()
        XCTAssertNil(selection.selectedUseCase)
        selection.selectedLink = .insurance
        selection.changeAfterPickingSomething()
        XCTAssertNil(selection.selectedTestCase)
        selection.selectedLink = .enviroment
        selection.changeAfterPickingSomething()
        XCTAssertNil(selection.selectedTestCase)
        XCTAssertNil(selection.selectedUseCase)
        selection.selectedLink = .useCase
        selection.changeAfterPickingSomething()
        XCTAssertNil(selection.selectedTestCase)
    }
    func testAfterLoad() {
        XCTAssertFalse(selection.configFileisIncorrect)
    }
    func testLinkBuilderUniversal() {
        selection.selectedEnvironment = selection.aplications.first!.universalLink.backendEnviroment.first!
        selection.selectedInsurance = selection.selectedEnvironment?.insurance?.first!
        selection.selectedUseCase = selection.aplications.first!.universalLink.useCase.first!
        selection.selectedTestCase = selection.selectedUseCase?.testCase?.first!
        XCTAssertEqual(selection.buildLinkUniversal(),
                       "https://hv-CGJ-ogs-integration.apps.cx.ocp.aws.aok-systems.de/site/register-confirm?code=005056BDA7651EDB9F89990F6E4BAE1E")
    }
    func testLinkBuilderAppToApp() {
        selection.selectedUseCases = selection.aplications.first!.appToApp.useCase.first!
        XCTAssertEqual("https://www.aok.de/meine-aok-app/mailbox", selection.buildLinkAppToApp())
    }
}
