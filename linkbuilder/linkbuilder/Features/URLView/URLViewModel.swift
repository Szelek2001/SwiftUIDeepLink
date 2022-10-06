//
//  URLViewModel.swift
//  linkbuilder
//
//  Created by Axxiome Health on 06/10/2022.
//

import Foundation
import UIKit

class URLViewModel: ObservableObject {
    func writeToClipboard(text clipboard: String ) {
        let pasteboard = UIPasteboard.general
        pasteboard.string = clipboard
    }

}
