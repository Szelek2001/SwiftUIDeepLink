//
//  BadConfigFileView.swift
//  linkbuilder
//
//  Created by Axxiome Health on 12/10/2022.
//

import SwiftUI

struct BadConfigFileView: View {
    var body: some View {
        VStack {
            Spacer()
            Image("rejected")
            Spacer()
        }
    }
}

struct BadConfigFileView_Previews: PreviewProvider {
    static var previews: some View {
        BadConfigFileView()
    }
}