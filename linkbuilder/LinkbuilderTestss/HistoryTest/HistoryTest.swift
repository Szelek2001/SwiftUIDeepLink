import XCTest
@testable import linkbuilder
final class HistoryTest: XCTestCase {
    var history: HistoryViewModel!
    let badURL = "this is bad url"
    let okURL = "https://www.facebook.com/"
    override func setUp() {
        super.setUp()
        history = HistoryViewModel()
    }
    override func tearDown() {
        history = nil
        super.tearDown()
    }
    func testOpenURL() {
        XCTAssertThrowsError(try history.openURL(urlString: badURL))
        XCTAssertNoThrow(try history.openURL(urlString: okURL))
    }
    func testDelateHistory() {
        let historyOld = UserDefaults.standard.stringArray(forKey: Constant.keyForHistory) ?? []
        history.delateToHistory(url: "joj")
        let historyNew = UserDefaults.standard.stringArray(forKey: Constant.keyForHistory) ?? []
        XCTAssertEqual(historyOld, historyNew)
        
        
    }
}
