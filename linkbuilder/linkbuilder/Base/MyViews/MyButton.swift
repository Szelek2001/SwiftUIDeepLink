import SwiftUI
struct MyButton: View {
    var text: String
    var icon: Image?
    var isDisable: Bool = true
    var clicked: (() -> Void)
    var body: some View {
        Button(action: clicked) {
            HStack {
                Text(text)
                icon
            }
            .padding(10)
            .frame(minHeight: 45)
            .background(buttonbackColor)
            .foregroundColor(Color(.aokWhite!))
            .cornerRadius(10)
            .shadow(radius: 1.0)
            .aspectRatio(contentMode: .fit)
            .scaledToFit()
            .disabled(isDisable)
        }
    }
    var buttonbackColor: Color {
        return isDisable ? Color(.aokGreen!) : Color(.aokGray2!)
    }
}
