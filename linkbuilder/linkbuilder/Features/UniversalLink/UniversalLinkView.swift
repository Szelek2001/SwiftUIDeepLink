//
//  UniversalLinkView.swift
//  linkbuilder
//
//  Created by Axxiome Health on 07/10/2022.
//

import SwiftUI

struct UniversalLinkView: View {
    @StateObject var viewModel: SelectionViewModel
    @State var URLLinkIsShow: Bool = false
    var body: some View {
        VStack {
            VStack {
                PickerWithText(
                    text: TextSelectionLinks.selectEnviroment,
                    title: "",
                    selection: $viewModel.selectedEnvironment) {
                    ForEach(viewModel.backendEnvironment!, id: \.self) { enviroment in
                        Text(enviroment.name)
                            .tag(enviroment as BackendEnviroment?)
                    }
                }.onChange(of: viewModel.selectedEnvironment) { _ in
                    viewModel.selectedLink = .enviroment
                    viewModel.changeAfterPickingSomething()
                    }
                 }
            Spacer(minLength: 30)
            if viewModel.selectedLink == .enviroment ||
                viewModel.selectedLink == .insurance ||
                viewModel.selectedLink == .useCase ||
                viewModel.selectedLink == .testCase {
                VStack {
                    PickerWithText(
                        text: TextSelectionLinks.selectInsurance,
                        title: "",
                        selection: $viewModel.selectedInsurance) {
                        ForEach(viewModel.insurance ?? [], id: \.self) { insurance in
                            Text(insurance.name)
                                .tag(insurance as Insurance?)
                        }
                    }
                        .onChange(of: viewModel.selectedInsurance) { _ in
                        guard viewModel.selectedInsurance == nil else {
                            viewModel.selectedLink = .insurance
                            viewModel.changeAfterPickingSomething()
                            return
                        }
                    }
                }}
            Spacer(minLength: 30)
            if viewModel.selectedLink == .insurance ||
                viewModel.selectedLink == .useCase ||
                viewModel.selectedLink == .testCase {
                VStack {
                    PickerWithText(
                        text: TextSelectionLinks.selectUseCase,
                        title: "",
                        selection: $viewModel.selectedUseCase) {
                        ForEach(viewModel.useCase!, id: \.self) { useCase in
                            Text(useCase.name)
                                .tag(useCase as UseCase?)
                        }
                    }
                    .onChange(of: viewModel.selectedUseCase) { _ in
                            guard viewModel.selectedUseCase == nil else {
                                viewModel.selectedLink = .useCase
                                viewModel.changeAfterPickingSomething()
                            return
                        }
                    }
                }
            }
            Spacer(minLength: 30)
            if viewModel.selectedLink == .useCase ||
                viewModel.selectedLink == .testCase {
                VStack {
                    PickerWithText(
                        text: TextSelectionLinks.selectTestCase,
                        title: "", selection: $viewModel.selectedTestCase) {
                        ForEach(viewModel.testCase ?? [], id: \.self) { testCase in
                            Text(testCase.name)
                                .tag(testCase as TestCase?)
                        }
                    }
                        .onChange(of: viewModel.selectedTestCase) { _ in
                        guard viewModel.selectedTestCase == nil else {
                            viewModel.selectedLink = .testCase
                            viewModel.changeAfterPickingSomething()
                        return
                        }
                    }
                }
            }
            Spacer(minLength: 30)
            if viewModel.selectedLink == .testCase {
                VStack {
                    MyButton(text: TextSelectionLinks.confirm ) {
                        URLLinkIsShow = true
                    }.sheet(isPresented: $URLLinkIsShow) {
                        URLView(viewModel: URLViewModel(), urlLink: viewModel.makelinkUniversal())
                    }
                }
            }
        }
    }
}

struct UniversalLinkView_Previews: PreviewProvider {
    static var previews: some View {
        UniversalLinkView(viewModel: SelectionViewModel())
    }
}
