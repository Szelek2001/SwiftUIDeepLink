import SwiftUI

struct HistoryView: View {
    @StateObject var viewModel: HistoryViewModel = HistoryViewModel()
    @State private var showingBadURLAlert = false
    @State private var urlFunction: URLService = URLService()
    var body: some View {
        ZStack {
            List {
                ForEach(viewModel.history, id: \.self) { url in
                    Text(url)
                        .swipeActions(edge: .trailing) {
                            Button {
                                do {
                                    try urlFunction.openURL(urlString: url)
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
                                    urlFunction.delateToHistory(url: url)
                                    await viewModel.reload()
                                }
                            }
                        label: {
                            Text(TextHistory.delate)}
                        }
                        .tint(Color.aokRed)
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
                .embedInNavigation()
                .safeAreaInset(edge: .bottom, alignment: .center, spacing: 0) {
                    Color.clear
                        .frame(height: 0)
                        .background(Material.bar)
                }
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
