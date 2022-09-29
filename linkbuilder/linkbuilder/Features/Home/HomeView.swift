//
//  ContentView.swift
//  linkbuilder
//
//  Created by Axxiome Health on 27/09/2022.
//

import SwiftUI
import Lottie

struct HomeView: View {
    var body: some View {
        TabView {
            SelectionView().tabItem {
                Symbols.checklist
            Text("Selection")
        }
            SplashScreen().tabItem {
                Symbols.gear
                Text("Settings")
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
