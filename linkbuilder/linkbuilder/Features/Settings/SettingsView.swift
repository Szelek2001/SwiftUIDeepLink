//
//  SettingsView.swift
//  linkbuilder
//
//  Created by Axxiome Health on 12/10/2022.
//

import SwiftUI

struct SettingsView: View {
    @State private var showSourceCode = false
    @State var sourceCodeName: String = UserDefaults.standard.string(forKey: "configFile") ?? " "
    @State var editDisable: Bool = true
    var body: some View {
        ZStack {
            Color(.aokGray1!).ignoresSafeArea(edges: .top)
            VStack {
                Spacer()
                Toggle(TextSettings.previewFile, isOn: $showSourceCode)
                Spacer()
                Text(TextSettings.currentFile)
                MyTextEditor(text: sourceCodeName, editDisable: editDisable)
                Spacer()
                HStack {
                    MyButton(
                        text: TextSymbols.save,
                        icon: Symbols.save,
                        isDisable: editDisable
                    ) {
                        UserDefaults.standard.set(sourceCodeName, forKey: "configFile")
                    }
                    MyButton(
                        text: TextSymbols.modification,
                        icon: Symbols.modification,
                        isDisable: true
                    ) {
                        editDisable.toggle()
                    }}
                Spacer()
            }
            // TODO: Paddingi
            .padding(20)
            .sheet(isPresented: $showSourceCode) {
                TextEditor(text: jsonToString(json: $sourceCodeName)).padding(50)
            }
        }
    }
    func jsonToString(json: AnyObject){
        do {
            let data1 =  try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted)
            let convertedString = String(data: data1, encoding: String.Encoding.utf8)
        } catch let myJSONError {
            print(myJSONError)
        }
        
    }
}
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
