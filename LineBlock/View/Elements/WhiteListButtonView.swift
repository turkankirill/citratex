
import SwiftUI

struct WhiteListButtonView: View {
    var body: some View {
        HStack(spacing: 16) {
            Image("checkboxes")
                .resizable()
                .scaledToFit()
                .frame(width: 40)
            
            VStack(alignment: .leading) {
                Text("White List")
                    .font(.workSans(.SemiBold, style: .subheadline))
                    .foregroundColor(.bRobinEggBlue)
                Text("Sites that will not be blocked")
                    .font(.workSans(.Regular, style: .footnote))
                    .opacity(0.3)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Image("pen")
                .resizable()
                .scaledToFit()
                .frame(width: 40)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 30, style: .continuous)
            .fill(.white)
            .shadow(color: .bRobinEggBlue.opacity(0.3), radius: 10))
    }
}
