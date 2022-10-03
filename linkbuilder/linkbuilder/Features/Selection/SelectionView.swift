//
//  SelectionView.swift
//  linkbuilder
//
//  Created by Axxiome Health on 29/09/2022.
//

import SwiftUI

struct SelectionView: View {
    @StateObject var viewModel: SelectionViewModel
    @State private var selectedEnvironment: BackendEnviroment = BackendEnviroment(name: "", staticPath: "", insurance: nil)
    @State private var selectedInsurance: Insurance = Insurance(name: "", subdomain: "")
    @State private var selectedUseCase: UseCase = UseCase(name: "")
    @State private var selectedtestCase: TestCase = TestCase(name: "", param: "")
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
                            ForEach(viewModel.backendEnvironment, id: \.self) { user in
                                Text(user.name)
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
                                ForEach(viewModel.insurance, id: \.self) { user in
                                    Text(user.name)
                                }
                            }.pickerStyle(SegmentedPickerStyle()).colorMultiply(Color(.aokGreen!)).onChange(of: selectedInsurance) { _ in
                                if selectedInsurance.name != "" {
                                    selected = .insurance
                                    afterPickingSomething()
                                }
                            }
                        }}
                    Spacer(minLength: 30)
                    if isSelectedInsurance {
                        VStack {
                            Text("Select UseCase:")

                            Picker("", selection: $selectedUseCase) {
                                ForEach(viewModel.useCase, id: \.self) { user in
                                    Text(user.name)
                                }}.pickerStyle(SegmentedPickerStyle()).colorMultiply(Color(.aokGreen!)).onChange(of: selectedUseCase) { _ in
                                if selectedUseCase.name != "" {
                                    selected = .useCase
                                    afterPickingSomething()
                                }
                            }
                        }
                    }
                    Spacer(minLength: 30)
                    if isSelectedTestCase {
                        VStack {
                            Text("Select TestCase:")
                            Picker("", selection: $selectedtestCase) {
                                ForEach(viewModel.testCase, id: \.self) { user in
                                    Text(user.name)
                                }
                            }.pickerStyle(SegmentedPickerStyle()).colorMultiply(Color(.aokGreen!)).onChange(of: selectedtestCase) { _ in
                                if selectedtestCase.name != "" {
                                    selected = .testCase}
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
            viewModel.insurance = selectedEnvironment.insurance!
            isSelectedEnviroment = true
            isSelectedInsurance = false
            isSelectedTestCase = false
            selectedUseCase = UseCase(name: "")
            selectedInsurance = Insurance(name: "", subdomain: "")
        case .insurance:
            selectedUseCase = UseCase(name: "")
            selectedtestCase = TestCase(name: "", param: "")
            isSelectedInsurance = true
            isSelectedTestCase = false
        case .useCase:
            viewModel.testCase = selectedUseCase.testCase ?? []
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
