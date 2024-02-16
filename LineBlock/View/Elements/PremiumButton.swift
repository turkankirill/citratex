

import SwiftUI

struct PremiumButton: View {
    var body: some View {
        VStack {
            VStack(spacing: 24) {
                Text("PREMIUM")
                    .font(.workSans(.Bold, style: .title2))
                    .foregroundColor(Color.bMintCream)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 24)
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("Subscription Settings")
                        .font(.workSans(.SemiBold, style: .body))
                        .foregroundColor(Color.bMintCream)
                    
                    Text("Unlock Exclusive Features \nand Functions")
                        .font(.workSans(.Light, style: .subheadline))
                        .foregroundColor(Color.bMintCream)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.vertical, 32)
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 24)
            .background(RoundedRectangle(cornerRadius: 30, style: .continuous)
                .fill(Color.bRobinEggBlue)
            )
        }
        .overlay(alignment: .topTrailing) {
            Image("crown")
                .resizable()
                .scaledToFit()
                .foregroundColor(Color.bGunmetal)
                .padding(.vertical, 24)
                .padding(.trailing, 8)
                .background(Color.clear)
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal)
        .shadow(color: .bRobinEggBlue.opacity(0.3), radius: 10)
    }
}
