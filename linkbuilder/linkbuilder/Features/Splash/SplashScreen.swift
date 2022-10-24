import SwiftUI

struct SplashScreen: View {
    var body: some View {
        LottieView(lottieFile: "lottie-tree.json").frame(width: 300, height: 300)
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
