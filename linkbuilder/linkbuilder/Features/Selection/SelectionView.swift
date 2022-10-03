//
//  SelectionView.swift
//  linkbuilder
//
//  Created by Axxiome Health on 29/09/2022.
//

import SwiftUI

struct SelectionView: View {
    @StateObject var viewModel: SelectionViewModel
    @State private var selectedEnvironment: BackendEnviroment?
    @State private var selectedInsurance: Insurance?
    @State private var selectedUseCase: UseCase?
    @State private var selectedtestCase: TestCase?
    @State private var isSelectedEnviroment = false
    @State private var isSelectedInsurance = false
    @State private var isSelectedTestCase = false
    @State private var selected: Selected = .aplication
    var body: some View {
        ZStack {
            Color(.aokGray1!).ignoresSafeArea(edges: .top)
            SplashScreen().opacity(0.2)
            ScrollView {
                Spacer(minLength: 30)
                VStack {
                    VStack {
                        Text("Select enviroment: ")
                        Picker("", selection: $selectedEnvironment) {
                            ForEach(viewModel.backendEnvironment, id: \.self) { enviroment in
                                Text(enviroment.name).tag(enviroment as BackendEnviroment?)
                            }
                        }.pickerStyle(SegmentedPickerStyle()).colorMultiply(Color(.aokGreen!)).onChange(of: selectedEnvironment) { _ in
                            selected = .enviroment
                            afterPickingSomething()
                            }
                         }
                    Spacer(minLength: 30)
                    if isSelectedEnviroment {
                        VStack {
                            Text("Select Kasse:")
                            Picker("", selection: $selectedInsurance) {
                                ForEach(viewModel.insurance, id: \.self) { insurance in
                                    Text(insurance.name).tag(insurance as Insurance?)
                                }
                            }.pickerStyle(SegmentedPickerStyle()).colorMultiply(Color(.aokGreen!)).onChange(of: selectedInsurance) { _ in
                                guard selectedInsurance?.name == nil else {
                                    selected = .insurance
                                    afterPickingSomething()
                                    return
                                }
                            }
                        }}
                    Spacer(minLength: 30)
                    if isSelectedInsurance {
                        VStack {
                            Text("Select UseCase:")

                            Picker("", selection: $selectedUseCase) {
                                ForEach(viewModel.useCase, id: \.self) { useCase in
                                    Text(useCase.name).tag(useCase as UseCase?)
                                }}.pickerStyle(SegmentedPickerStyle()).colorMultiply(Color(.aokGreen!)).onChange(of: selectedUseCase) { _ in
                                    guard selectedUseCase?.name == nil else {
                                    selected = .useCase
                                    afterPickingSomething()
                                    return
                                }
                            }
                        }
                    }
                    Spacer(minLength: 30)
                    if isSelectedTestCase {
                        VStack {
                            Text("Select TestCase:")
                            Picker("", selection: $selectedtestCase) {
                                ForEach(viewModel.testCase, id: \.self) { testCase in
                                    Text(testCase.name).tag(testCase as TestCase?)
                                }
                            }.pickerStyle(SegmentedPickerStyle()).colorMultiply(Color(.aokGreen!)).onChange(of: selectedtestCase) { _ in
                                guard selectedtestCase == nil else {
                                    selected = .testCase
                                    return
                                }
                            }
                        }
                    }
                }
            }.task {
                viewModel.loadJson(filename: "config")
            }
        }.navigationTitle("\(viewModel.aplications.first?.name ?? "") is Selected").embedInNavigation()
    }
    func afterPickingSomething() {
        switch selected {
        case .aplication:
            print("XD")
        case .enviroment:
            viewModel.insurance = (selectedEnvironment?.insurance!)!
            isSelectedEnviroment = true
            isSelectedInsurance = false
            isSelectedTestCase = false
            selectedUseCase = nil
            selectedInsurance = nil
        case .insurance:
            selectedUseCase = nil
            selectedtestCase = nil
            isSelectedInsurance = true
            isSelectedTestCase = false
        case .useCase:
            viewModel.testCase = selectedUseCase?.testCase ?? []
            isSelectedTestCase = true
        case .testCase:
            print("wyswietl")
        }
    }
}

struct SelectionView_Previews: PreviewProvider {
    static var previews: some View {
        SelectionView(viewModel: SelectionViewModel())
    }
}


// zapytaj jak ex zrobic
