import SwiftUI

struct SettingsView: View {
    @State private var showSourceCode = false
    @State var viewModel: SettingsViewModel = SettingsViewModel()
    @State var editDisable: Bool = true
    var body: some View {
        NavigationView {
            ZStack {
                Color(.aokGray1!).ignoresSafeArea(edges: .top)
                VStack {
                    Spacer()
                    Toggle(TextSettings.previewFile, isOn: $showSourceCode)
                    Spacer()
                    MyTextEditor(text: $viewModel.sourceCodeName, editDisable: editDisable)
                    Spacer()
                    HStack {
                        MyButton(
                            text: TextSymbols.save,
                            icon: Symbols.save,
                            isDisable: editDisable
                        ) {
                            viewModel.save()
                        }
                        MyButton(
                            text: TextSymbols.modification,
                            icon: Symbols.modification,
                            isDisable: true
                        ) {
                            editDisable.toggle()
                        }}
                    Spacer()
                }
                .padding(20)
                .sheet(isPresented: $showSourceCode) {
                    TextEditor(
                        text: $viewModel.jsonSourceCode.toUnwrapped(defaultValue: TextSettings.badJSONFile))
                    .padding(50)
                }
            }.task {
                await viewModel.load()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                refresh
                }
            }
            .navigationTitle(TextSettings.settings)
        }
    }
    var refresh: some View {
        Button {
            Task {
                await viewModel.load()
            }
        } label: {
            Symbols.refresh.colorMultiply(Color(.aokGreen!))
        }
    }
}
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
extension Binding {
     func toUnwrapped<T>(defaultValue: T) -> Binding<T> where Value == Optional<T> {
        Binding<T>(get: { self.wrappedValue ?? defaultValue }, set: { self.wrappedValue = $0 })
    }
}
