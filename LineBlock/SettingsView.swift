
import SwiftUI

struct SettingsView: View {
    @State var showTerms = false
    @State var showPPEULA = false
    var body: some View {
        ScrollView(showsIndicators: false) {
            NavigationLink(destination: SubscriptionView()) {
                PremiumButton()
            }
                .padding(.bottom)
            NavigationLink(destination: TutView()) {
                SettingsCellView(image: "tutorial", title: "Tutorial", subtitle: "Sites that will not be blocked")
                    .padding(.horizontal)
                    .padding(.bottom, 12)
            }
            LazyVGrid(columns: Array(repeating: GridItem(), count: 2), spacing: 16) {
                
//                    .padding(.trailing, 4)
//                SettingsCellView(image: "contact", title: "Contact Us", subtitle: "Sites that will not be blocked")
//                    .padding(.leading, 4)
                SettingsCellView(image: "sharing", title: "Share App", subtitle: "Sites that will not be blocked")
                    .onTapGesture {
                        RateReviewBranx.activityBranx()
                    }
                    .padding(.trailing, 4)
                SettingsCellView(image: "rate", title: "Rate App", subtitle: "Sites that will not be blocked")
                    .onTapGesture {
                        RateReviewBranx.rateBranx()
                    }
                    .padding(.leading, 4)
                SettingsCellView(image: "termsOfUse", title: "Terms of Use", subtitle: "Sites that will not be blocked")
                    .onTapGesture {
                        showTerms.toggle()
                    }
                    .padding(.trailing, 4)
                SettingsCellView(image: "PrivacyPolicy", title: "Privacy Policy", subtitle: "Sites that will not be blocked")
                    .onTapGesture {
                        showPPEULA.toggle()
                    }
                    .padding(.leading, 4)
            }
            .padding(.horizontal)
            .padding(.bottom, 100)
        }
        .sheet(isPresented: $showTerms) {
            BrowserView(url: URL(string: Terms.shared.terms())!).ignoresSafeArea()
        }
        .sheet(isPresented: $showPPEULA) {
            BrowserView(url: URL(string: Terms.shared.privacy())!).ignoresSafeArea()
        }
    }
}

#Preview {
    SettingsView()
}



struct SettingsCellView: View {
    let image: String
    let title: String
    let subtitle: String
    
    var body: some View {
        VStack(spacing: 16) {
            HStack() {
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 35)
                
                Text(title)
                    .font(.workSans(.SemiBold, style: .subheadline))
                    .foregroundColor(.bRobinEggBlue)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
                Text(subtitle)
                    .font(.workSans(.Regular, style: .footnote))
                    .opacity(0.3)
            
//            .frame(maxWidth: .infinity, alignment: .leading)
            
        }
        .frame(maxWidth: .infinity)
        .padding(24)
        .background(RoundedRectangle(cornerRadius: 30, style: .continuous)
            .fill(.white)
            .shadow(color: .bRobinEggBlue.opacity(0.3), radius: 10))
//        .padding(.horizontal)
        
    }
}
