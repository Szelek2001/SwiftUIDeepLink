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
            SplashScreen().opacity(Costant.splashScreenOpacity)
            ScrollView {
                Picker("", selection: $viewModel.selectedApp) {
                    Text(TextSelection.appToApp).tag(Selected.appToApp)
                    Text(TextSelection.universalLink).tag(Selected.universalLink)
                }.pickerStyle(SegmentedPickerStyle())
                    .colorMultiply(Color(.aokGreen!))
                Spacer(minLength: 30)
                if viewModel.selectedApp == .universalLink {
                    UniversalLinkView(viewModel: viewModel)
                }
                if viewModel.selectedApp == .appToApp {
                    AppToAppView(viewModel: viewModel)
                }
            }.task {
                viewModel.loadJson(filename: "config")
            }.padding(10)
        }.navigationTitle( viewModel.aplications.first?.name ?? "" + TextSelectionLinks.isSelected).embedInNavigation()
    }

}

struct SelectionView_Previews: PreviewProvider {
    static var previews: some View {
        SelectionView(viewModel: SelectionViewModel())
    }
}

// zapytaj jak ex zrobic
