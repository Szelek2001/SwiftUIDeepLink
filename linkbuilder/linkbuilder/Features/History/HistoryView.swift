import SwiftUI

struct HistoryView: View {
    @ObservedObject var viewModel: HistoryViewModel = HistoryViewModel()
    @State private var showingBadURLAlert = false
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.history, id: \.self) { url in
                    Text(url)
                        .swipeActions(edge: .trailing) {
                            Button {
                                do {
                                    try viewModel.openURL(urlString: url)
                                } catch {
                                    showingBadURLAlert = true
                                }
                            }
                        label: {
                            Text(TextHistory.openSite)
                            }
                        .tint(Color(.aokGreen!))
                            }
                        .swipeActions(edge: .leading) {
                            Button {
                                Task {
                                viewModel.delateToHistory(url: url)
                                await viewModel.reload()
                                }
                            }
                        label: {
                            Text(TextHistory.delate)}
                        }
                        .tint(Color(.aokRed!))
                }
            }
            .alert(TextHistory.notURL, isPresented: $showingBadURLAlert) {
                Button(TextHistory.ok, role: .cancel) { }
                    }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                refresh
                }
            }.navigationTitle(TextHistory.history)
                .refreshable {
                    await viewModel.reload()
                }
        }
    }
    var refresh: some View {
        Button {
            Task {
                await viewModel.reload()
            }
        } label: {
            Symbols.refresh.colorMultiply(Color(.aokGreen!))
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
