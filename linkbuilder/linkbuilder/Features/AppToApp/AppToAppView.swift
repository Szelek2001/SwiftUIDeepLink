import SwiftUI

struct AppToAppView: View {
    @ObservedObject var viewModel: SelectionViewModel
    @State var URLLinkIsShow: Bool = false
    var body: some View {
        VStack {
            VStack {
                PickerWithText(
                    text: TextSelectionLinks.selectUseCase,
                    title: "",
                    selection: $viewModel.selectedUseCases) {
                        ForEach(viewModel.useCases!, id: \.self) { usecases in
                            Text(usecases.name).tag(usecases as UseCase?)
                        }
                    }.onChange(of: viewModel.selectedUseCases) { _ in
                        viewModel.selectedAppToApp = .usecases
                    }
            }
            Spacer()
            if viewModel.selectedAppToApp == .usecases {
                VStack {
                    Spacer(minLength: 20)
                    ButtonWithText(text: TextSelectionLinks.confirm ) {
                        URLLinkIsShow = true
                    }.sheet(isPresented: $URLLinkIsShow) {
                        URLView(viewModel: URLViewModel(), urlLink: viewModel.buildLinkAppToApp())
                    }
                }
            }
        }
    }
}

struct AppToAppView_Previews: PreviewProvider {
    static var previews: some View {
        AppToAppView(viewModel: SelectionViewModel())
    }
}
