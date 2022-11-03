import Foundation
import UIKit

class URLViewModel: ObservableObject {
    enum URLError: Error {
        case badURL
    }
    func writeToClipboard(url clipboard: String ) {
        let pasteboard = UIPasteboard.general
        pasteboard.string = clipboard
    }
    func saveToHistory(url: String) {
        var history = UserDefaults.standard.stringArray(forKey: Constant.keyForHistory) ?? []
        if history.capacity >= Constant.maxHistoryCapacity {
            history.removeLast()
        }
        history.insert( url, at: 0)
        UserDefaults.standard.set(history, forKey: Constant.keyForHistory)
    }
    func verifyUrl (urlString: String?) -> Bool {
        if let urlString = urlString {
            if let url = NSURL(string: urlString) {
                return UIApplication.shared.canOpenURL(url as URL)
            }
        }
        return false
    }
    func openURL(urlString: String) throws {
        if verifyUrl(urlString: urlString) == false {
            throw URLError.badURL
        }
        guard let url = URL(string: urlString) else {
            throw URLError.badURL }
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
}
