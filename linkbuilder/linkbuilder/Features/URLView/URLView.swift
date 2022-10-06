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
    var body: some View {
        VStack {
            Text(urlLink).padding()
            HStack {
                MyButton(
                    text: TextURL.copy,
                    icon: Symbols.copy
                ) {
                    print("Copy")
                }
                MyButton(
                    text: TextURL.save,
                    icon: Symbols.save
                ) {
                    viewModel.writeToClipboard(text: urlLink)
                }
            }

        }.navigationTitle(TextURL.currentUrl).embedInNavigation()
    }
}

struct URLView_Previews: PreviewProvider {
    static var previews: some View {
        URLView(viewModel: URLViewModel(), urlLink: "MAMAMIJA")
    }
}
