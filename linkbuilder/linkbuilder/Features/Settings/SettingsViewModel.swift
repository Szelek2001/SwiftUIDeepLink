//
//  SettingsViewModel.swift
//  linkbuilder
//
//  Created by Axxiome Health on 18/10/2022.
//

import Foundation

class SettingsViewModel: ObservableObject {
    @Published var jsonSourceCode: String? = nil
    func load() async{
        if let url = Bundle.main.path(
            forResource: UserDefaults.standard.string(
                forKey: Constant.keyForConfig),
            ofType: "json") {
            do {
                let constents = try String(contentsOfFile: url)
                DispatchQueue.main.async {
                    self.jsonSourceCode = constents
                }
            } catch let _ as NSError {
                self.jsonSourceCode = nil
            }
        } else {
            self.jsonSourceCode = nil
        }
    }
}
