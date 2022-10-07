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
                ForEach(viewModel.history, id: \.self) {
                    Text($0)
            }
            }
            .toolbar {ToolbarItem(placement: .navigationBarTrailing) {
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
