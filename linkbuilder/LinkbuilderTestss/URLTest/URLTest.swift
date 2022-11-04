import XCTest
@testable import linkbuilder
final class URLTest: XCTestCase {
    var url: URLViewModel!
    let badURL = "this is bad url"
    let okURL = "https://www.facebook.com/"
    var urlService: URLService = URLService()
    override func setUp() {
        super.setUp()
        url = URLViewModel()
    }
    override func tearDown() {
        url = nil
        super.tearDown()
    }
    func testOpenURL() {
        XCTAssertThrowsError(try urlService.openURL(urlString: badURL))
        XCTAssertNoThrow(try urlService.openURL(urlString: okURL))
    }
    func testWriteToClipboard() {
        XCTAssertNoThrow(url.writeToClipboard(url: ":)"))
    }
    func testSaveToHistory() {
        UserDefaults.standard.set([], forKey: Constant.keyForHistory)
        let history = [":)"]
        urlService.saveToHistory(url: ":)")
        XCTAssertEqual(history, UserDefaults.standard.stringArray(forKey: Constant.keyForHistory))
    }
}
