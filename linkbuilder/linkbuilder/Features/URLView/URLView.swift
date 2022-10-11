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
    @State var isIncorrectURL: Bool = false
    var body: some View {
        ZStack {
            Color(.aokGray1!).ignoresSafeArea(edges: .top)
            SplashScreen().opacity(0.2)
            VStack {
                Spacer()
                TextEditor(text: $urlLink)
                    .disabled(editDisable).colorMultiply(editDisable ?  Color(.aokGray1!) : Color(.aokWhite!))
                    .padding()
                Spacer()
                HStack {
                    MyButton(
                        text: TextURL.copy,
                        icon: Symbols.copy,
                        isDisable: editDisable
                    ) {
                        viewModel.writeToClipboard(url: urlLink)
                    }
                    MyButton(
                        text: TextURL.save,
                        icon: Symbols.save,
                        isDisable: editDisable
                    ) {
                        if viewModel.verifyUrl(urlString: urlLink) {
                            viewModel.saveToHistory(url: urlLink)
                        } else {
                            isIncorrectURL = true
                        }
                    }
                    MyButton(
                        text: TextURL.modification,
                        icon: Symbols.modification
                    ) {
                        editDisable.toggle()
                    }
                }.alert(TextURL.alertIncorrectUrl, isPresented: $isIncorrectURL) {
                    Button(TextURL.cancel, role: .cancel) { }
                    Button(TextURL.add) { viewModel.saveToHistory(url: urlLink) }
                }
                Spacer(minLength: 30)
            }
        }.navigationTitle(TextURL.currentUrl).embedInNavigation()
    }
}

struct URLView_Previews: PreviewProvider {
    static var previews: some View {
        URLView(viewModel: URLViewModel(), urlLink: "MAMAMIJA")
    }
}
