//
//  MyPicker.swift
//  linkbuilder
//
//  Created by Axxiome Health on 14/10/2022.
//

import SwiftUI
struct PickerWithText<Label, SelectionValue, Content> : View where Label: StringProtocol, SelectionValue : Hashable, Content : View {
    typealias Content = View
    var text: String
    var title: Label
    var selection: Binding<SelectionValue>
    var content: (() -> Content)
    var body: some View {
        Text(text)
        Picker(title, selection: selection, content: content)
            .pickerStyle(SegmentedPickerStyle())
            .colorMultiply(Color(.aokGreen!))
    }
}
