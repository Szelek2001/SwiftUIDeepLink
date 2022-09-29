//
//  SplashScreen.swift
//  linkbuilder
//
//  Created by Axxiome Health on 28/09/2022.
//

import SwiftUI

struct SplashScreen: View {
    var body: some View {
        LottieView(lottieFile: "lottie.json").frame(width: 300, height: 300)
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
