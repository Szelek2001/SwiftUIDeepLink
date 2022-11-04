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
        case name = "application-name"
        case universalLink = "universal-link"
        case appToApp = "app-to-app"
    }
}

extension Config: Hashable {
    static func == (lhs: Config, rhs: Config) -> Bool {
        lhs.id == rhs.id
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
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
    var useCase: [UseCase]
    private enum CodingKeys: String, CodingKey {
        case staticPath = "static-path"
        case useCase = "use-case"
    }
}
struct BackendEnviroment: Codable {
    var name: String
    var staticPath: String
    var insurance: [Insurance]?
    private enum CodingKeys: String, CodingKey {
        case staticPath = "static-path"
        case name = "name"
        case insurance = "insurance"
    }
}
extension BackendEnviroment: Hashable, Equatable {
    static func == (lhs: BackendEnviroment, rhs: BackendEnviroment) -> Bool {
        lhs.name == rhs.name
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}
struct UseCase: Codable {
    var name: String
    var actions: [String]?
    var testCase: [TestCase]?
    var action: String?
    private enum CodingKeys: String, CodingKey {
        case name = "name"
        case actions = "actions"
        case testCase = "test-case"
        case action = "action"
    }
}
extension UseCase: Hashable, Equatable {
    static func == (lhs: UseCase, rhs: UseCase) -> Bool {
        lhs.name == rhs.name
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}
struct Insurance: Codable {
    var name: String
    var subdomain: String
}
extension Insurance: Hashable, Equatable {
    static func == (lhs: Insurance, rhs: Insurance) -> Bool {
        lhs.name == rhs.name
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}
struct TestCase: Codable {
    var name: String
    var param: String
}
extension TestCase: Hashable {
    static func == (lhs: TestCase, rhs: TestCase) -> Bool {
        lhs.name == rhs.name
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}
