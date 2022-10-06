//
//  SelectionView.swift
//  linkbuilder
//
//  Created by Axxiome Health on 29/09/2022.
//

import SwiftUI

struct SelectionView: View {
    @StateObject var viewModel: SelectionViewModel
    @State var isready: Bool = false
    var body: some View {
        ZStack {
            Color(.aokGray1!).ignoresSafeArea(edges: .top)
            SplashScreen().opacity(0.2)
            ScrollView {
                Spacer(minLength: 30)
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
                            viewModel.selected = .enviroment
                            viewModel.changeAfterPickingSomething()
                            }
                         }
                    Spacer(minLength: 30)
                    if viewModel.selected == .enviroment || viewModel.selected == .insurance || viewModel.selected == .useCase || viewModel.selected == .testCase {
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
                                    viewModel.selected = .insurance
                                    viewModel.changeAfterPickingSomething()
                                    return
                                }
                            }
                        }}
                    Spacer(minLength: 30)
                    if viewModel.selected == .insurance || viewModel.selected == .useCase || viewModel.selected == .testCase {
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
                                        viewModel.selected = .useCase
                                        viewModel.changeAfterPickingSomething()
                                    return
                                }
                            }
                        }
                    }
                    Spacer(minLength: 30)
                    if viewModel.selected == .useCase || viewModel.selected == .testCase {
                        VStack {
                            Text(TextSelection.selectTestCase)
                            Picker("", selection: $viewModel.selectedtestCase) {
                                ForEach(viewModel.testCase!, id: \.self) { testCase in
                                    Text(testCase.name)
                                        .tag(testCase as TestCase?)
                                }
                            }.pickerStyle(SegmentedPickerStyle())
                                .colorMultiply(Color(.aokGreen!))
                                .onChange(of: viewModel.selectedtestCase) { _ in
                                guard viewModel.selectedtestCase == nil else {
                                    viewModel.selected = .testCase
                                    viewModel.changeAfterPickingSomething()
                                return
                                }
                            }
                        }
                    }
                    Spacer(minLength: 30)
                    if viewModel.selected == .testCase {
                        VStack {
                            MyButton(
                                text: TextSelection.confirm                            ) {
                                viewModel.makelink()
                                isready = true
                            }.sheet(isPresented: $isready) {
                                URLView(viewModel: URLViewModel(), urlLink: ":)")                                }
                        }
                    }
                }
            }.task {
                viewModel.loadJson(filename: "config")
            }.padding(10)
        }.navigationTitle( viewModel.aplications.first?.name ?? "" + TextSelection.isSelected).embedInNavigation()
    }

}

struct SelectionView_Previews: PreviewProvider {
    static var previews: some View {
        SelectionView(viewModel: SelectionViewModel())
    }
}

// zapytaj jak ex zrobic
