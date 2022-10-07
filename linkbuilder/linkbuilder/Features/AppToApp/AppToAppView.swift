//
//  AppToAppView.swift
//  linkbuilder
//
//  Created by Axxiome Health on 07/10/2022.
//

import SwiftUI

struct AppToAppView: View {
    @StateObject var viewModel: SelectionViewModel
    @State var URLLinkIsShow: Bool = false
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct AppToAppView_Previews: PreviewProvider {
    static var previews: some View {
        AppToAppView(viewModel: SelectionViewModel())
    }
}
