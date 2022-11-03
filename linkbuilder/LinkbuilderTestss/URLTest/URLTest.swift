import XCTest
@testable import linkbuilder
final class URLTest: XCTestCase {
    var url: URLViewModel!
    let badURL = "this is bad url"
    let okURL = "https://www.facebook.com/"
    override func setUp() {
        super.setUp()
        url = URLViewModel()
    }
    override func tearDown() {
        url = nil
        super.tearDown()
    }
    func testOpenURL() {
        XCTAssertThrowsError(try url.openURL(urlString: badURL))
        XCTAssertNoThrow(try url.openURL(urlString: okURL))
    }
    func testWriteToClipboard() {
        XCTAssertNoThrow(url.writeToClipboard(url: ":)"))
    }
    func testSaveToHistory() {
        UserDefaults.standard.set([], forKey: Constant.keyForHistory)
        let history = [":)"]
        url.saveToHistory(url: ":)")
        XCTAssertEqual(history, UserDefaults.standard.stringArray(forKey: Constant.keyForHistory))
    }
}
