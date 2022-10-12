//
//  URLViewModel.swift
//  linkbuilder
//
//  Created by Axxiome Health on 06/10/2022.
//

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
        var history = UserDefaults.standard.stringArray(forKey: "history") ?? []
        if history.capacity >= 10 {
            history.removeLast()
        }
        history.insert( url, at: 0)
        UserDefaults.standard.set(history, forKey: "history")
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
