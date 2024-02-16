
import StoreKit
import SwiftUI

struct SubscriptionCell: View {
    @ObservedObject var subscription = SubscriptionVM()
    @Binding var exit: Bool
//    @AppStorage(ConstantsBranx.flow.onboardingSeenKey) var showOnboard = true
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        if !subscription.myProducts.isEmpty {
            VStack(spacing: 0) {
                VStack(spacing: 16) {
                    ForEach(subscription.myProducts, id: \.self) { product in
                        if product.productIdentifier.contains("week") || product.productIdentifier.contains("month") || product.productIdentifier.contains("anual") {
                            Button(action: {
                                subscription.purchaseProduct(product: product)
                            }) {
                                Products(product: product)
                            }
                        }
                    }
                }
                
                Text("Continue")
                    .font(.workSans(.Regular, style: .title3))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 74)
                    .background(RoundedRectangle(cornerRadius: 20 , style: .continuous)
                        .fill(Color.bRobinEggBlue)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                    )
                    .shadow(color: .bRobinEggBlue.opacity(0.7) ,radius: 10)
                    .padding(.top)
                    .onTapGesture {
                        if let productToPurchase = subscription.myProducts.first(where: { $0.productIdentifier.contains("week") }) {
                            subscription.purchaseProduct(product: productToPurchase)
                        }
                    }
            }
            .padding(.horizontal)
            .navigationBarItems(leading: Text("Restore Purchase")
                .font(.workSans(.Regular, style: .footnote))
                .foregroundColor(Color.white)
                .padding(8)
                .background(Color.bRobinEggBlue.cornerRadius(16))
                
                                
                    .onTapGesture {
                        subscription.renewalItemsManager()
                    })
            .onAppear { SKPaymentQueue.default().add(subscription) }
            .onDisappear { SKPaymentQueue.default().remove(subscription) }
            
            .navigationBarItems(trailing: Image(systemName: "xmark")
                .padding()
                .offset(x: 16)
                .onTapGesture{

                    presentationMode.wrappedValue.dismiss()

            })
            .navigationBarBackButtonHidden(true)
        }
    }
}
struct SubscriptionCell_Previews: PreviewProvider {
    static var previews: some View {
        SubscriptionCell(exit: .constant(false))
    }
}

struct Products: View {
    var period: String
    var price: String
    var isSelect = false
    var freeTrial = ""
    
    init(product: SKProduct) {
        price = product.localizedPrice ?? "Error"
        
        switch product.subscriptionPeriod?.unit {
        case .day:
            period = "week"
        case .week:
            period = "Weekly Subsription"
            isSelect = true
            freeTrial = " with 3 day trial"
        case .month:
            period = "Monthly Subsription "
        case .year:
            period = "Annualy Subsription "
        case .none:
            period = "none"
        case .some:
            period = "unknown"
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack{
                VStack {
                    Text(period)
                        .font(.workSans(.Regular, style: .body))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("\(price)\(freeTrial)")
                        .font(.workSans(.Regular, style: .title3))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.bGunmetal)
                }
                .padding(.vertical)
                Text("Save 40%")
                    .foregroundColor(.white)
                    .font(.workSans(.Regular, style: .footnote))
                    .padding(.vertical, 4)
                    .padding(.horizontal, 8)
                    .background(RoundedRectangle(cornerRadius: 25)
                        .fill(Color.bRobinEggBlue)
                    )
                    .opacity(period != "Annualy Subsription " ? 0 : 1)
            }
            .padding(.horizontal)
        }
        .background(RoundedRectangle(cornerRadius: 16)
            .fill(Color.white)
            .shadow(color: .bRobinEggBlue.opacity(0.3), radius: 10)
        )
        
    }
}
