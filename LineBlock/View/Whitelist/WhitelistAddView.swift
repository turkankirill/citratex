
import SwiftUI

struct WhitelistAddView: View {
    @ObservedObject var vm: ContentblockersViewModel

    @Environment(\.presentationMode) var presentationMode
    
    @State private var textfieldString: String = .empty
    @State private var showPremium = Bool()
    
    var body: some View {
        ZStack {
            Color.bMintCream.ignoresSafeArea()
            
            VStack(spacing: 16) {
                HStack {
                    dismissButton
                    
                    Spacer()
                    
                    doneButton
                }
                .background(Color.bMintCream)
                VStack(spacing: 0) {
                    title
                        .frame(minWidth: .zero, maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 16)
                    
                    
                    textfield
                        .padding(.horizontal, 16)
                }
                Spacer()
            }
        }
        .sheet(isPresented: $showPremium) {
            SubscriptionView()
        }
    }
}

extension WhitelistAddView {
    
    private var dismissButton: some View {
        Button {
            presentationMode.wrappedValue.dismiss()
        } label: {
            Text("Cancel")
                .font(.workSans(.Regular, style: .body))
                .foregroundColor(.bRobinEggBlue)
        }
    }
    
    private var doneButton: some View {
        Button {
            if Acquisitions.shared.isPaid {
            vm.addToList(type: .whitelist, textfieldString)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    presentationMode.wrappedValue.dismiss()
                }
            } else {
                showPremium = true
            }
        } label: {
            Text("Add")
                .font(.workSans(.Regular, style: .body))
                .foregroundColor(.bRobinEggBlue)
        }
    }
    
    private var title: some View {
        Text("Add website")
            .font(.workSans(.Regular, style: .title))
            .foregroundColor(.bGunmetal)
    }
    
    private var textfield: some View {
        VStack(spacing: 12.0) {
            TextField("website.com", text: $textfieldString)
                .font(.workSans(.Regular, style: .body))
                .foregroundColor(.bGunmetal)
//                .foregroundColor(.textMain)
                .autocorrectionDisabled(true)
                .autocapitalization(.none)
                .keyboardType(.URL)
                .padding(.vertical)
                .background(RoundedRectangle(cornerRadius: 20)
                    .stroke(lineWidth: 1.0)
                    .fill(Color.bGunmetal))
                .shadow(color: Color.bRobinEggBlue ,radius: 10)
        }
    }
}
