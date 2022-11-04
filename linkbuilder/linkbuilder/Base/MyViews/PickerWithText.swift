import SwiftUI
struct PickerWithText<Label, SelectionValue, Content> : View where Label: StringProtocol, SelectionValue : Hashable, Content : View {
    typealias Content = View
    var text: String
    var title: Label
    var selection: Binding<SelectionValue>
    var content: (() -> Content)
    var body: some View {
        Text(text)
        Picker("", selection: selection, content: content)
            .pickerStyle(SegmentedPickerStyle())
    }
    init(text: String, title: Label, selection: Binding<SelectionValue>, content: @escaping (() -> Content)) {
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor.aokGreen
        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.white]
        UISegmentedControl.appearance().setTitleTextAttributes(attributes, for: .selected)
        self.text = text
        self.title = title
        self.selection = selection
        self.content = content
    }
}
