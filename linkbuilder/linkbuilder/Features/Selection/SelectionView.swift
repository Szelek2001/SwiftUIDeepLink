import SwiftUI

struct SelectionView: View {
    @StateObject var viewModel: SelectionViewModel
    var body: some View {
        ZStack {
            Color(.aokGray1!).ignoresSafeArea(edges: .top)
            SplashScreen().opacity(Constant.splashScreenOpacity)
            ScrollView {
                VStack {
                    if !viewModel.configFileisIncorrect {
                        PickerWithText(text: TextSelection.selectType, title: "", selection: $viewModel.selectedApp) {
                            TextPicker()
                        }       .onChange(of: viewModel.selectedApp) { _ in
                                viewModel.selectedLink = .nothing
                                viewModel.changeAfterPickingSomething()
                            }
                        Spacer(minLength: 30)
                    } else {
                        Spacer(minLength: 30)
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
struct TextPicker: View {
    var body: some View {
        Text(TextSelection.appToApp).tag(Selected.appToApp)
        Text(TextSelection.universalLink).tag(Selected.universalLink)
    }
}

struct SelectionView_Previews: PreviewProvider {
    static var previews: some View {
        SelectionView(viewModel: SelectionViewModel())
    }
}
