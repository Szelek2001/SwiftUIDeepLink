import Foundation
import UIKit

class URLViewModel: ObservableObject {
    func writeToClipboard(url clipboard: String ) {
        let pasteboard = UIPasteboard.general
        pasteboard.string = clipboard
    }
}
