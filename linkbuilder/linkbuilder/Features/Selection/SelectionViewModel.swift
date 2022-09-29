//
//  SelectionViewModel.swift
//  linkbuilder
//
//  Created by Axxiome Health on 29/09/2022.
//

import Foundation

class SelectionViewModel {
    func loadJson(filename fileName: String) {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(ConfigData.self, from: data)
            } catch {
                print("error:\(error)")
            }
        }
    }
}
