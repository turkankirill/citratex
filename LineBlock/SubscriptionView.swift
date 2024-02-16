
import SwiftUI

struct SubscriptionView: View {
    var body: some View {
        VStack(spacing: 36) {
            VStack {
                Image("crown")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50)
                
                Text("Get full acces now")
                    .font(.workSans(.Bold, style: .title2))
            }
            VStack(spacing: 16) {
                SubscriptionOfferCell(image: "filter", title: "Multiple blocking categories - enable even more content filters")
                
                SubscriptionOfferCell(image: "takeover", title: "Get total secutity with easy privacy and phising filtering")
                
                SubscriptionOfferCell(image: "startup", title: "Remove all ads and enjoy the superior performance with Premium")
            }
            
            SubscriptionCell(exit: .constant(true))
        }
    }
}

#Preview {
    SubscriptionView()
}

struct SubscriptionOfferCell: View {
    let image: String
    let title: String
    var body: some View {
        HStack(spacing: 16) {
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(width: 40)
            Text(title)
                .font(.workSans(.Regular, style: .subheadline))
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.horizontal)
    }
}
