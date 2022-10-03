//
//  SelectionViewModel.swift
//  linkbuilder
//
//  Created by Axxiome Health on 29/09/2022.
//

import Foundation

class SelectionViewModel: ObservableObject {
    @Published private(set) var backendEnvironment: [BackendEnviroment] = []
    @Published  var insurance: [Insurance] = []
    @Published  var useCase: [UseCase] = []
    @Published  var testCase: [TestCase] = []

    @Published private(set) var aplications: [Config] = []
    func loadJson(filename fileName: String) {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(ConfigData.self, from: data)
                backendEnvironment = jsonData.config.first!.universalLink.backendEnviroment
                aplications = jsonData.config
                useCase = jsonData.config.first!.universalLink.useCase
            } catch {
                print("error:\(error)")
            }
        }
    }
}

enum Selected {
    case aplication
    case enviroment
    case insurance
    case useCase
    case testCase
}
