//
//  MyTextEditor.swift
//  linkbuilder
//
//  Created by Axxiome Health on 14/10/2022.
//
import SwiftUI
struct MyTextEditor: View {
    @State var text: String
    var editDisable: Bool
    var frameHeight: CGFloat? = 40
    var body: some View {
        TextEditor(text: $text)
            .disabled(editDisable)
            .colorMultiply(editDisable ?  Color(.aokGray1!) : Color(.aokWhite!))
            .cornerRadius(10)
            .frame(height: frameHeight)
            .shadow(radius: 1.0)
            .padding()
    }
}
