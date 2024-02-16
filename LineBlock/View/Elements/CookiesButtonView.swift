
import SwiftUI

struct CookiesButtonView: View {
    @State var isToggleOn = false
    var body: some View {
        VStack {
            Image("cookies")
                .resizable()
                .scaledToFit()
                .frame(width: 50)
            
            Text("Blocking script on in app designed to obtain data points preferences")
                .font(.workSans(.Regular, style: .caption))
                .foregroundColor(.bRobinEggBlue)
                .frame(maxHeight: 100)
                .multilineTextAlignment(.center)
            
        }
        .padding()
        .frame(maxWidth: .infinity)
        .frame(height: 170)
        .background(RoundedRectangle(cornerRadius: 30, style: .continuous)
            .fill(.white)
            .shadow(color: .bRobinEggBlue.opacity(0.3), radius: 10))
        .padding(.leading, 6)

    }
}

#Preview {
    CookiesButtonView()
}
