//
//  URLView.swift
//  linkbuilder
//
//  Created by Axxiome Health on 05/10/2022.
//

import SwiftUI

struct URLView: View {
    @StateObject var viewModel: URLViewModel
    @State var urlLink: String
    @State var editDisable: Bool = true
    var body: some View {
        ZStack {
            Color(.aokGray1!).ignoresSafeArea(edges: .top)
            SplashScreen().opacity(0.2)
            VStack {
                Spacer()
                TextEditor(text: $urlLink).disabled(editDisable).padding()
                Spacer()
                HStack {
                    MyButton(
                        text: TextURL.copy,
                    icon: Symbols.copy
                    ) {
                        viewModel.writeToClipboard(url: urlLink)
                    }
                    MyButton(
                        text: TextURL.save,
                        icon: Symbols.save
                    ) {
                        viewModel.saveToHistory(url: urlLink)
                    }
                    MyButton(
                        text: TextURL.modification,
                        icon: Symbols.modification
                    ) {
                        editDisable.toggle()
                    }
                }
                Spacer()

            }
        }.navigationTitle(TextURL.currentUrl).embedInNavigation()
    }
}

struct URLView_Previews: PreviewProvider {
    static var previews: some View {
        URLView(viewModel: URLViewModel(), urlLink: "MAMAMIJA")
    }
}
