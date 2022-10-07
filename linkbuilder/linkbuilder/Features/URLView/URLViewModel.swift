//
//  URLViewModel.swift
//  linkbuilder
//
//  Created by Axxiome Health on 06/10/2022.
//

import Foundation
import UIKit

class URLViewModel: ObservableObject {
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

}
