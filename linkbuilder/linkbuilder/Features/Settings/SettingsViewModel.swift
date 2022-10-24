import Foundation

class SettingsViewModel: ObservableObject {
    @Published var jsonSourceCode: String?
    @Published var sourceCodeName: String = UserDefaults.standard.string(forKey: Constant.keyForConfig) ?? " "

    func load() async {
        if let url = Bundle.main.path(
            forResource: UserDefaults.standard.string(
                forKey: Constant.keyForConfig),
            ofType: "json") {
            do {
                let constents = try String(contentsOfFile: url)
                DispatchQueue.main.async {
                    self.jsonSourceCode = constents
                }
            } catch _ as NSError {
                self.jsonSourceCode = nil
            }
        } else {
            self.jsonSourceCode = nil
        }
    }
    func save() {
        UserDefaults.standard.set(sourceCodeName, forKey: Constant.keyForConfig)
    }
}
