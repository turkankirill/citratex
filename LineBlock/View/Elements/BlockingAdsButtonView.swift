
import SwiftUI

struct BlockingAdsButtonView: View {
    var body: some View {
        VStack {
            Image("bullhorn")
                .resizable()
                .scaledToFit()
                .frame(width: 50)
            
            Text("Blocking ads on many popular information sites around the world")
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
        .padding(.trailing, 6)
    }
}
