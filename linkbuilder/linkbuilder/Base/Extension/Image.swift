import Foundation
import UIKit

extension UIImage {
    static let camera = UIImage(named: "camera")
    static let eye = UIImage(systemName: "eye")?.withTintColor(.aokGreen ?? .green, renderingMode: .alwaysOriginal)
    static let backButton = UIImage(systemName: "xmark")?.withTintColor(.aokGreen ?? .green, renderingMode: .alwaysOriginal)
    static let radioButtonSelected = UIImage(systemName: "circle.circle.fill")?.withTintColor(.aokGray4 ?? .black, renderingMode: .alwaysOriginal)
    static let radioButtonNoSelected = UIImage(systemName: "circle")?.withTintColor(.aokGray4 ?? .black, renderingMode: .alwaysOriginal)
    static let cancelation = UIImage(named: "cancelation")
    static let rejected = UIImage(named: "rejected")
    static let successful = UIImage(named: "successful")
    static let coodePerMail = UIImage(named: "codePerMail")
}
