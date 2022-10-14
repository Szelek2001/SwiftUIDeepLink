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
                VStack {
                    if !viewModel.configFileisIncorrect {
                        Text(TextSelection.selectType)
                        Picker("", selection: $viewModel.selectedApp) {
                            Text(TextSelection.appToApp).tag(Selected.appToApp)
                            Text(TextSelection.universalLink).tag(Selected.universalLink)
                        }.pickerStyle(SegmentedPickerStyle())
                            .colorMultiply(Color(.aokGreen!))
                            .onChange(of: viewModel.selectedApp) {_ in
                                viewModel.selectedLink = .nothing
                                viewModel.changeAfterPickingSomething()
                            }
                        Spacer(minLength: 30)
                    } else {
                        Spacer(minLength: 55)
                        BadConfigFileView()
                    }}
                if viewModel.selectedApp == .universalLink {
                    UniversalLinkView(viewModel: viewModel)
                }
                if viewModel.selectedApp == .appToApp {
                    AppToAppView(viewModel: viewModel)
                }
            }.padding(20)
        }
        .navigationTitle(viewModel.configFileisIncorrect
                         ? TextSelection.configIncorrect
                         : ((viewModel.aplications.first?.name ?? "") + TextSelectionLinks.isSelected))
        .embedInNavigation()
        .task { do {
            try viewModel.loadJson()
        } catch {
                viewModel.configFileisIncorrect = true
            }
        }

    }

}

struct SelectionView_Previews: PreviewProvider {
    static var previews: some View {
        SelectionView(viewModel: SelectionViewModel())
    }
}

// zapytaj jak ex zrobic
