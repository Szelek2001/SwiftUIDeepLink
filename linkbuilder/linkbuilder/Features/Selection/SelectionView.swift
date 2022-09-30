//
//  SelectionView.swift
//  linkbuilder
//
//  Created by Axxiome Health on 29/09/2022.
//

import SwiftUI

struct SelectionView: View {
    @StateObject var viewModel: SelectionViewModel
    @State private var selectedEnvironment: BackendEnviroment = BackendEnviroment(name: "", staticPath: "", insurance: nil)
    var body: some View {
        ZStack {
            Color(.aokGray1!).ignoresSafeArea(edges: .top)
            SplashScreen().opacity(0.2)
            ScrollView {
                HStack {
                    Picker("", selection: $selectedEnvironment) {
                        ForEach(viewModel.backendEnvironment, id: \.self) { user in
                            Text(user.name)
                        }}
                    Text(selectedEnvironment.name) }
            }.task {
                viewModel.loadJson(filename: "config")
                selectedEnvironment = viewModel.backendEnvironment.first!
            }
        }.navigationTitle("\(viewModel.aplications.first?.name ?? "") is Selected").embedInNavigation()
    }
}

struct SelectionView_Previews: PreviewProvider {
    static var previews: some View {
        SelectionView(viewModel: SelectionViewModel())
    }
}
