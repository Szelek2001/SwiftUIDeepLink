import SwiftUI
struct ButtonWithText: View {
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
            .scaleEffect()
        }
        .withPressableStyle()
        
    }
    var buttonbackColor: Color {
        return isDisable ? Color(.aokGreen!) : Color(.aokGray2!)
    }
}
struct PressableButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
            .opacity(configuration.isPressed ? 0.9 : 1.0)
    }
}

extension View {
    func withPressableStyle() -> some View {
        buttonStyle(PressableButtonStyle())
    }
}
