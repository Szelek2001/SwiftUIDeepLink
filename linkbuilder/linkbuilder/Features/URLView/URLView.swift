import SwiftUI

struct URLView: View {
    @ObservedObject var viewModel: URLViewModel
    @State var urlLink: String
    @State var editDisable: Bool = true
    @State var isIncorrectURL: Bool = false
    @State private var showingBadURLAlert = false
    @State private var urlFunction: URLService = URLService()

    var body: some View {
        ZStack {
            Color.aokGray1.ignoresSafeArea(edges: .top)
            SplashScreen().opacity(Constant.splashScreenOpacity)
            VStack {
                TextEditorWithCharLimit(
                    text: $urlLink,
                    editDisable: editDisable,
                    frameHeight: 140)
                Spacer()
                HStack {
                    ButtonWithText(
                        text: TextURL.goToLink,
                        icon: Symbols.goToLink,
                        isDisable: editDisable
                    ) {
                        do {
                            try urlFunction.openURL(urlString: urlLink)
                        } catch {
                            showingBadURLAlert = true
                        }
                    }.alert(TextHistory.notURL, isPresented: $showingBadURLAlert) {
                        Button(TextHistory.ok, role: .cancel) { }
                    }
                    ButtonWithText(
                        text: TextSymbols.copy,
                        icon: Symbols.copy,
                        isDisable: editDisable
                    ) {
                        viewModel.writeToClipboard(url: urlLink)
                    }
                    ButtonWithText(
                        text: TextSymbols.save,
                        icon: Symbols.save,
                        isDisable: editDisable
                    ) {
                        if urlFunction.verifyUrl(urlString: urlLink) {
                            urlFunction.saveToHistory(url: urlLink)
                        } else {
                            isIncorrectURL = true
                        }
                    }
                }
            }.padding(20)
        }.toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                modification
            }}.navigationTitle(TextURL.currentUrl).embedInNavigation()
    }
    var modification: some View {
        Button {
            Task {
                editDisable.toggle()
            }
        } label: {
            Symbols.modification.colorMultiply(Color.aokGreen)
        }.alert(TextURL.alertIncorrectUrl, isPresented: $isIncorrectURL) {
            Button(TextURL.cancel, role: .cancel) { }
            Button(TextURL.add) { urlFunction.saveToHistory(url: urlLink) }
        }
    }
}

struct URLView_Previews: PreviewProvider {
    static var previews: some View {
        URLView(viewModel: URLViewModel(), urlLink: "MAMAMIJA")
    }
}
