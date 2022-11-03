import Foundation
import UIKit

class HistoryViewModel: ObservableObject {
    enum URLError: Error {
        case badURL
    }
    @Published private(set) var history: [String] = UserDefaults.standard.stringArray(forKey: Constant.keyForHistory) ?? []
    @MainActor
    func reload() async {
        history = UserDefaults.standard.stringArray(forKey: Constant.keyForHistory) ?? []
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
    func delateToHistory(url: String) {
        var history = UserDefaults.standard.stringArray(forKey: Constant.keyForHistory) ?? []
        let number = history.firstIndex(of: url)
        if  number == nil {
            return
        }
        history.remove(at: number!)
        UserDefaults.standard.set(history, forKey: Constant.keyForHistory)
    }
    private func verifyUrl (urlString: String?) -> Bool {
        if let urlString = urlString {
            if let url = NSURL(string: urlString) {
                return UIApplication.shared.canOpenURL(url as URL)
            }
        }
        return false
    }
    
}
