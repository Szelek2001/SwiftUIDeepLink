import Foundation

struct ConfigData: Codable {
    var config: [Config]
    private enum CodingKeys: String, CodingKey {
        case config = "config_data"
    }
}
struct Config: Codable {
    var id: String
    var name: String
    var universalLink: UniversalLink
    var appToApp: AppToApp
    private enum CodingKeys: String, CodingKey {
        case id = "application-id"
        case name = "Meine AOK"
        case universalLink = "universal-link"
        case appToApp = "app-to-app"
    }
}
struct UniversalLink: Codable {
    var backendEnviroment: [BackendEnviroment]
    var useCase: [UseCase]
    private enum CodingKeys: String, CodingKey {
        case backendEnviroment = "backend-environment"
        case useCase = "use-case"
    }
}
struct AppToApp: Codable {
    var staticPath: String
    var useCase: UseCase
    private enum CodingKeys: String, CodingKey {
        case staticPath = "static-path"
        case useCase = "use-case"
    }
}
struct BackendEnviroment: Codable {
    var name: String
    var staticPath: String
    var insurance: [Insurance]
    private enum CodingKeys: String, CodingKey {
        case staticPath = "static-path"
        case name = "name"
        case insurance = "insurance"
    }
}
struct UseCase: Codable {
    var name: String
    var actions: [String]
    var testCase: [TestCase]?
    var action: String?
    private enum CodingKeys: String, CodingKey {
        case name = "name"
        case actions = "actions"
        case testCase = "test-case"
        case action = "action"
    }
}
struct Insurance: Codable {
    var name: String
    var subdomain: String
}
struct TestCase: Codable {
    var name: String
    var param: String
}
