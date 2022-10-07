//
//  HistoryViewModel.swift
//  linkbuilder
//
//  Created by Axxiome Health on 07/10/2022.
//

import Foundation

class HistoryViewModel: ObservableObject {
    @Published private(set) var history: [String] = UserDefaults.standard.stringArray(forKey: "history") ?? []
    @MainActor
    func reload() async {
        history = UserDefaults.standard.stringArray(forKey: "history") ?? []
    }
}
