import Foundation
import UIKit

class HistoryViewModel: ObservableObject {
    @Published private(set) var history: [String] = UserDefaults.standard.stringArray(forKey: Constant.keyForHistory) ?? []
    @MainActor
    func reload() async {
        history = UserDefaults.standard.stringArray(forKey: Constant.keyForHistory) ?? []
    }
}
