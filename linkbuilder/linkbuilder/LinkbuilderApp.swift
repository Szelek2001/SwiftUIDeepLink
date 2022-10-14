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
                        Text(TextSymbols.selection)
            }
                URLView(viewModel: URLViewModel(), urlLink: TextMain.addYourText)
                    .tabItem {
                    Symbols.new
                        Text(TextSymbols.new)
                }
                HistoryView()
                    .tabItem {
                    Symbols.history
                        Text(TextSymbols.history)
                }
                SettingsView()
                    .tabItem {
                    Symbols.gear
                        Text(TextSymbols.settings)
                }
            }
        }
    }
}
