import XCTest
@testable import linkbuilder
final class SetingsTest: XCTestCase {
    var settings: SettingsViewModel!
    override func setUp() {
        super.setUp()
        settings = SettingsViewModel()
    }
    override func tearDown() {
        settings = nil
        super.tearDown()
    }
    func testsave() {
        let example = "barka"
        settings.sourceCodeName = example
        settings.save()
        XCTAssertEqual(example, UserDefaults.standard.string(forKey: Constant.keyForConfig))
    }
    func testLoadBadFile() async {
        UserDefaults.standard.set("c", forKey: Constant.keyForConfig)
        await settings.load()
        XCTAssertNil(settings.jsonSourceCode)
    }
    func testLaod() async {
        UserDefaults.standard.set("config", forKey: Constant.keyForConfig)
        await settings.load()
    }
}
