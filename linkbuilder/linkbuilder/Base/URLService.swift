import Foundation
import UIKit

class URLService {
    enum URLError: Error {
        case badURL
    }
    func openURL(urlString: String) throws {
        if verifyUrl(urlString: urlString) == false {
            throw URLError.badURL
        }
        guard let url = URL(string: urlString) else {
            throw URLError.badURL }
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    func delateToHistory(url: String) {
        var history = UserDefaults.standard.stringArray(forKey: Constant.keyForHistory) ?? []
        let number = history.firstIndex(of: url)
        if  number == nil {
            return
        }
        history.remove(at: number!)
        UserDefaults.standard.set(history, forKey: Constant.keyForHistory)
    }
    func verifyUrl(urlString: String?) -> Bool {
        if let urlString = urlString {
            if let url = URL(string: urlString) {
                return UIApplication.shared.canOpenURL(url )
            }
        }
        return false
    }
    func saveToHistory(url: String) {
        var history = UserDefaults.standard.stringArray(forKey: Constant.keyForHistory) ?? []
        if history.capacity >= Constant.maxHistoryCapacity {
            history.removeLast()
        }
        history.insert( url, at: 0)
        UserDefaults.standard.set(history, forKey: Constant.keyForHistory)
    }
}
