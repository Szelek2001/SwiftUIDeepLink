//
//  SelectionViewModel.swift
//  linkbuilder
//
//  Created by Axxiome Health on 29/09/2022.
//

import Foundation

class SelectionViewModel: ObservableObject {
    @Published private(set) var backendEnvironment: [BackendEnviroment]?
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
    @Published var configFileisIncorrect = false
    @Published private(set) var aplications: [Config] = []
    enum LoginFileError: Error {
        case noFileFoundError
        case encodingError
    }
    func loadJson() throws {
        restart()
        if let url = Bundle.main.url(
            forResource: UserDefaults.standard.string(
                forKey: Constant.keyForConfig),
                withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(ConfigData.self, from: data)
                backendEnvironment = jsonData.config.first!.universalLink.backendEnviroment
                aplications = jsonData.config
                useCase = jsonData.config.first!.universalLink.useCase
                useCases = jsonData.config.first!.appToApp.useCase
                configFileisIncorrect = false
            } catch {
                throw LoginFileError.noFileFoundError
            }
        } else {
            throw LoginFileError.encodingError
        }
    }
    func changeAfterPickingSomething() {
        switch selectedLink {
        case .nothing:
            selectedEnvironment = nil
        case .enviroment:
            insurance = selectedEnvironment?.insurance ?? []
            selectedInsurance = nil
        case .insurance:
            selectedUseCase = nil
        case .useCase:
            testCase = selectedUseCase?.testCase ?? []
            selectedTestCase = nil
        case .testCase:
            ()
        }
    }
    func makelinkUniversal() -> String {
        return "https://\(selectedInsurance!.subdomain)-\(selectedEnvironment!.name)-"
        + "\(selectedEnvironment!.staticPath)/\((selectedUseCase!.actions?.first)!)?\(selectedTestCase!.param)"
    }
    func makelinkAppToApp() -> String {
        return "https://\(aplications.first!.appToApp.staticPath)\(( selectedUseCases!.action)!)"
    }
    func restart() {
        backendEnvironment = nil
        insurance = nil
        useCase = nil
        testCase = nil
        useCases = nil
        selectedEnvironment = nil
        selectedInsurance = nil
        selectedUseCase = nil
        selectedTestCase = nil
        selectedUseCases = nil
        selectedLink = .nothing
        selectedApp = .app
        selectedAppToApp = .nothing
        configFileisIncorrect = false
        aplications = []
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
