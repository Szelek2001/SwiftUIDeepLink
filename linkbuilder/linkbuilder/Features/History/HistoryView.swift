//
//  HistoryView.swift
//  linkbuilder
//
//  Created by Axxiome Health on 06/10/2022.
//

import SwiftUI

struct HistoryView: View {
    @ObservedObject var viewModel: HistoryViewModel = HistoryViewModel()
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.history, id: \.self) { url in
                    Text(url)
                        .swipeActions(edge: .trailing) {
                        Button {
                            viewModel.opensite(site: url)
                            }
                        label: {
                            Text("open site")
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
                            Text("delate")}
                        }
                        .tint(Color(.aokRed!))
                }
            }
            .toolbar {ToolbarItem(
                placement: .navigationBarTrailing) {
                refresh
            }
            }.navigationTitle("History")
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
