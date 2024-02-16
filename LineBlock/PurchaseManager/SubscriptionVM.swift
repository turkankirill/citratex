import Foundation
import StoreKit
import SwiftyStoreKit
import IHProgressHUD


class SubscriptionVM: NSObject, ObservableObject, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    
    @Published var myProducts = [SKProduct]()
    @Published var transactionState: SKPaymentTransactionState?
    @Published var hasPurchased: Bool = false
    @Published var selectedProduct: SKProduct?
    
    var request: SKProductsRequest!
    
    override init() {
        super.init()
        DispatchQueue.main.async {
            self.getProducts(productIDs: ImmutableValues.product.renewableIDs)
        }
    }
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        print("Response received successfully for productsRequest")
            
        if !response.products.isEmpty {
            print("Products found for request")
            for fetchedProduct in response.products {
                DispatchQueue.main.async {
                    self.myProducts.append(fetchedProduct)
                }
            }
        }
        
        for invalidIdentifier in response.invalidProductIdentifiers {
            print("Invalid product identifiers found: \(invalidIdentifier)")
        }
        
    }
    
    func getProducts(productIDs: [String]) {
        print("Requesting products from server")
        let request = SKProductsRequest(productIdentifiers: Set(productIDs))
        request.delegate = self
        request.start()
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchasing:
                print("Initiating purchase process")
                transactionState = .purchasing
            case .purchased:
                print("Purchase successful")
                UserDefaults.standard.set(true, forKey: ImmutableValues.product.isPaid)
                queue.finishTransaction(transaction)
                transactionState = .purchased
            case .restored:
                print("Purchase restored successfully")
                UserDefaults.standard.set(true, forKey: ImmutableValues.product.isPaid)
                queue.finishTransaction(transaction)
                transactionState = .restored
                NotificationController.shared().showPurchasesWereRestored()
            case .failed, .deferred:
                print("Payment process encountered an error")
                transactionState = .failed
            default:
                print("Unexpected transaction state")
                queue.finishTransaction(transaction)
            }
        }
    }
    
    func purchaseProduct(product: SKProduct) {
        if SKPaymentQueue.canMakePayments() {
            let payment = SKPayment(product: product)
            SKPaymentQueue.default().add(payment)
            purchase(productWith: product.productIdentifier, product: product)
            
        } else {
            print("User is unable to make payment.")
        }
    }
    
    func AcquireChosenItem() {
        guard let product = selectedProduct else { return }
        if SKPaymentQueue.canMakePayments() {
            let payment = SKPayment(product: product)
            SKPaymentQueue.default().add(payment)
            purchase(productWith: product.productIdentifier, product: product)
            
        } else {
            print("User is unable to make payment.")
        }
    }
    
    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        let transactionCount = queue.transactions.count
        if transactionCount == 0 {
            NotificationController.shared().showNoPurchasesToRestore()
        }
    }
    
    func transactionMonitor(_ queue: SKPaymentQueue, restoreCompletedTransactionsFailedWithError error: Error) {
        print(error)
    }
    
    func renewalItemsManager() {
        print("Restoring purchased products")
        SKPaymentQueue.default().restoreCompletedTransactions()
        
        IHProgressHUD.dismiss()
    }
    
    func purchase(productWith identifier: String, product: SKProduct? = nil) {
        IHProgressHUD.show()
        
        SwiftyStoreKit.purchaseProduct(identifier, quantity: 1, atomically: true) { result in
            switch result {
            case .success(let purchase):
                print("Purchase succeeded: \(purchase.productId)")
                
                var price = purchase.product.price
                if let introductoryPrice = purchase.product.introductoryPrice?.price { price = introductoryPrice }
                
                UserDefaults.standard.set(true, forKey: ImmutableValues.product.isPaid)
                
                IHProgressHUD.dismiss()
                
                self.hasPurchased.toggle()
                
            case .error(let error):
                self.ProcessPaymentIssue(error: error)
                IHProgressHUD.dismiss()
            }
        }
    }
    
    private func ProcessPaymentIssue(error: SKError) {
        switch error.code {
                case .unknown: NotificationController.shared().showUnknown()
                case .clientInvalid: NotificationController.shared().showClientInvalid()
                case .paymentCancelled: NotificationController.shared().showPaymentCancelled()
                case .paymentInvalid: NotificationController.shared().showPaymentInvalid()
                case .paymentNotAllowed: NotificationController.shared().showPaymentNotAllowed()
                case .storeProductNotAvailable: NotificationController.shared().showStoreProductNotAvailable()
                case .cloudServicePermissionDenied: NotificationController.shared().showCloudServicePermissionDenied()
                case .cloudServiceNetworkConnectionFailed: NotificationController.shared().showCloudServiceNetworkConnectionFailed()
                case .cloudServiceRevoked: NotificationController.shared().showCloudServiceRevoked()
                default: break
        }
    }
}
