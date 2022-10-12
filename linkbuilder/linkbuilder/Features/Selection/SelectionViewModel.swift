//
//  SelectionViewModel.swift
//  linkbuilder
//
//  Created by Axxiome Health on 29/09/2022.
//

import Foundation

class SelectionViewModel: ObservableObject {
    @Published private(set) var backendEnvironment: [BackendEnviroment] = []
    @Published private(set) var insurance: [Insurance]?
    @Published private(set)  var useCase: [UseCase]?
    @Published private(set) var testCase: [TestCase]?
    @Published private(set)  var useCases: [UseCase]?
    @Published var selectedEnvironment: BackendEnviroment?
    @Published var selectedInsurance: Insurance?
    @Published var selectedUseCase: UseCase?
    @Published var selectedTestCase: TestCase?
    @Published var selectedUseCases: UseCase?
    @Published var selectedLink: SelectedLink = .nothing
    @Published var selectedApp: Selected = .app
    @Published var selectedAppToApp: SelectedAppToApp = .nothing
    
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
                useCases = jsonData.config.first!.appToApp.useCase
            } catch {
                print("error:\(error)")
            }
        }
    }
    func changeAfterPickingSomething() {
        switch selectedLink {
        case .enviroment:
            insurance = selectedEnvironment?.insurance ?? []
            selectedUseCase = nil
            selectedInsurance = nil
        case .insurance:
            selectedUseCase = nil
            selectedTestCase = nil
        case .useCase:
            testCase = selectedUseCase?.testCase ?? []
        case .testCase:
            ()
        default: ()
        }
    }
    func makelinkUniversal() -> String {
        return "https://\(selectedInsurance!.subdomain)-\(selectedEnvironment!.name)-"
        + "\(selectedEnvironment!.staticPath)/\((selectedUseCase!.actions?.first)!)?\(selectedTestCase!.param)"
    }
    func makelinkAppToApp() -> String {
        return "https://\(aplications.first!.appToApp.staticPath)\(( selectedUseCases!.action)!)"
    }
}
enum SelectedLink {
    case nothing
    case enviroment
    case insurance
    case useCase
    case testCase
}
enum Selected {
    case app
    case appToApp
    case universalLink
}
enum SelectedAppToApp {
    case nothing
    case usecases
}
