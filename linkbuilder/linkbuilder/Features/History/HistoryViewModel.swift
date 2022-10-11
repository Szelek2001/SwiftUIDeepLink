//
//  HistoryViewModel.swift
//  linkbuilder
//
//  Created by Axxiome Health on 07/10/2022.
//

import Foundation
import UIKit

class HistoryViewModel: ObservableObject {
    @Published private(set) var history: [String] = UserDefaults.standard.stringArray(forKey: "history") ?? []
    @MainActor
    func reload() async {
        history = UserDefaults.standard.stringArray(forKey: "history") ?? []
    }
    func opensite(site: String) {
        guard let url = URL(string: site) else {
            return
        }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    func delateToHistory(url: String) {
        var history = UserDefaults.standard.stringArray(forKey: "history") ?? []
        let number = history.firstIndex(of: url)
        history.remove(at: number!)
        UserDefaults.standard.set(history, forKey: "history")
    }

}
