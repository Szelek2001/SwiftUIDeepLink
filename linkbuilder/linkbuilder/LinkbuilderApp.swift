//
//  linkbuilderApp.swift
//  linkbuilder
//
//  Created by Axxiome Health on 27/09/2022.
//

import SwiftUI

@main
struct LinkbuilderApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                SelectionView(viewModel: SelectionViewModel())
                    .tabItem {
                    Symbols.checklist
                Text("Selection")
            }
                SplashScreen()
                    .tabItem {
                    Symbols.gear
                    Text("Settings")
                }
            }
        }
    }
}
