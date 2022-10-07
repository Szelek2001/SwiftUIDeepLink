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
                Text(TextSelection.selectEnviroment)
                Picker("", selection: $viewModel.selectedEnvironment) {
                    ForEach(viewModel.backendEnvironment, id: \.self) { enviroment in
                        Text(enviroment.name)
                            .tag(enviroment as BackendEnviroment?)
                    }
                }.pickerStyle(SegmentedPickerStyle())
                    .colorMultiply(Color(.aokGreen!))
                    .onChange(of: viewModel.selectedEnvironment) { _ in
                    viewModel.selectedLink = .enviroment
                    viewModel.changeAfterPickingSomething()
                    }
                 }
            Spacer(minLength: 30)
            if viewModel.selectedLink == .enviroment || viewModel.selectedLink == .insurance || viewModel.selectedLink == .useCase || viewModel.selectedLink == .testCase {
                VStack {
                    Text(TextSelection.selectInsurance)
                    Picker("", selection: $viewModel.selectedInsurance) {
                        ForEach(viewModel.insurance!, id: \.self) { insurance in
                            Text(insurance.name)
                                .tag(insurance as Insurance?)
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                        .colorMultiply(Color(.aokGreen!))
                        .onChange(of: viewModel.selectedInsurance) { _ in
                        guard viewModel.selectedInsurance?.name == nil else {
                            viewModel.selectedLink = .insurance
                            viewModel.changeAfterPickingSomething()
                            return
                        }
                    }
                }}
            Spacer(minLength: 30)
            if viewModel.selectedLink == .insurance || viewModel.selectedLink == .useCase || viewModel.selectedLink == .testCase {
                VStack {
                    Text(TextSelection.selectUseCase)

                    Picker("", selection: $viewModel.selectedUseCase) {
                        ForEach(viewModel.useCase!, id: \.self) { useCase in
                            Text(useCase.name)
                                .tag(useCase as UseCase?)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .colorMultiply(Color(.aokGreen!))
                    .onChange(of: viewModel.selectedUseCase) { _ in
                            guard viewModel.selectedUseCase?.name == nil else {
                                viewModel.selectedLink = .useCase
                                viewModel.changeAfterPickingSomething()
                            return
                        }
                    }
                }
            }
            Spacer(minLength: 30)
            if viewModel.selectedLink == .useCase || viewModel.selectedLink == .testCase {
                VStack {
                    Text(TextSelection.selectTestCase)
                    Picker("", selection: $viewModel.selectedTestCase) {
                        ForEach(viewModel.testCase!, id: \.self) { testCase in
                            Text(testCase.name)
                                .tag(testCase as TestCase?)
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                        .colorMultiply(Color(.aokGreen!))
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
                    MyButton(text: TextSelection.confirm ) {
                        URLLinkIsShow = true
                    }.sheet(isPresented: $URLLinkIsShow) {
                        URLView(viewModel: URLViewModel(), urlLink: viewModel.makelink())
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
