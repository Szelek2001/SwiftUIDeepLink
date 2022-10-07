//
//  SelectionView.swift
//  linkbuilder
//
//  Created by Axxiome Health on 29/09/2022.
//

import SwiftUI

struct SelectionView: View {
    @StateObject var viewModel: SelectionViewModel
    var body: some View {
        ZStack {
            Color(.aokGray1!).ignoresSafeArea(edges: .top)
            SplashScreen().opacity(0.2)
            ScrollView {
                Spacer(minLength: 30)
                Picker("", selection: $viewModel.selectedApp) {
                    Text("App-to-APP").tag(Selected.appToApp)
                    Text("Universal").tag(Selected.universalLinks)
                }.pickerStyle(SegmentedPickerStyle())
                    .colorMultiply(Color(.aokGreen!))
                if viewModel.selectedApp == .universalLinks {
                    UniversalLinkView(viewModel: viewModel)}
            }.task {
                viewModel.loadJson(filename: "config")
            }.padding(10)
        }.navigationTitle( viewModel.aplications.first?.name ?? "" + TextSelection.isSelected).embedInNavigation()
    }

}

struct SelectionView_Previews: PreviewProvider {
    static var previews: some View {
        SelectionView(viewModel: SelectionViewModel())
    }
}

// zapytaj jak ex zrobic
