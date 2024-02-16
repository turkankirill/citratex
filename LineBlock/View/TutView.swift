
import SwiftUI

struct TutView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            
            VStack(spacing: 16.0) {
                
                TitleView(title: "How to activate?")
                StepsView()
                SettingsButtonView()
            }
            .padding(.horizontal, 16)
        }
        .navigationBarBackButtonHidden()
        .navigationBarItems(leading: Image(systemName: "chevron.backward.circle.fill").onTapGesture {
            presentationMode.wrappedValue.dismiss()
        })
        .navigationTitle("How to activate?")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DismissButton: View {
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text("Cancel")
            
                .foregroundColor(.accentColor)
        }
        .padding()
    }
}

struct TitleView: View {
    var title: String
    
    var body: some View {
        Text(title)
        
    }
}

struct StepsView: View {
    var body: some View {
        VStack(spacing: 16.0) {
            Group {
                Image("iosSettings")
                
                Text("Step 1")
                    .opacity(0.5)
                    .font(.workSans(.Regular, style: .subheadline))
                
                Text("Go to Settings")
                    .padding(.top, -8)
                    .font(.workSans(.SemiBold, style: .body))
            }
            
            ArrowView()
            
            Group {
                Image("tutorialSafari")
                    .resizable()
                    .scaledToFit()
                
                Text("Step 2")
                    .opacity(0.5)
                    .font(.workSans(.Regular, style: .subheadline))

                Text("Select Safari → Extensions")
                    .padding(.top, -8)
                    .font(.workSans(.SemiBold, style: .body))

            }
            
            ArrowView()
            
            Group {
                Text("Step 3")
                    .opacity(0.5)
                    .font(.workSans(.Regular, style: .subheadline))
                
                Text("Enable switch app\nand restart the app")
                    .multilineTextAlignment(.center)
                    .padding(.top, -8)
                    .font(.workSans(.SemiBold, style: .body))
                
            }
        }
    }
}

struct ArrowView: View {
    var body: some View {
        Image(systemName: "arrow.down")
            .foregroundColor(.accentColor)
    }
}

struct SettingsButtonView: View {
    var body: some View {
        Button(action: {
            guard let url = URL(string: "App-prefs:SAFARI&path=ContentBlockers") else { return }
            UIApplication.shared.open(url)
        }) {
            SimpleButton(text: "Open Settings")
        }
    }
}

struct SimpleButton: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(.workSans(.SemiBold, style: .body))
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(RoundedRectangle(cornerRadius: 20)
                .fill(Color.bRobinEggBlue))
            
    }
}
