

import Foundation
import StoreKit
import SwiftyStoreKit
import IHProgressHUD
import SwiftUI

class Acquisitions {
    var window: UIWindow?
	enum PurchaseRestoreResult {
		case restored, noPurchases, error
	}
	
	static var shared = Acquisitions()
    
    init() {
        SHTFunnelManagerBranx.shared.delegate = self
    }
    
    var isPaid: Bool {
//        get { return true }
        get { return UserDefaults.standard.bool(forKey: ImmutableValues.product.isPaid) }
        set { UserDefaults.standard.set(newValue, forKey: ImmutableValues.product.isPaid) }
    }
    
    var sandbox: Bool {
        #if DEBUG
        return true
        #else
        return false
        #endif
    }
    
    private var storeKitService: AppleReceiptValidator.VerifyReceiptURLType {
        return sandbox ? .sandbox : .production
    }
	
	func configureSwiftyStoreKit() {
		SwiftyStoreKit.completeTransactions(atomically: true) { purchases in
			for purchase in purchases {
				switch purchase.transaction.transactionState {
				case .purchased, .restored:
					if purchase.needsFinishTransaction {
						SwiftyStoreKit.finishTransaction(purchase.transaction)
					}
                default:
					break
                }
			}
		}
	}
	
	func updateReceipt() {
		if !isPaid { return }
		validateTransactionReceipt { _ in }
	}
	
	func refreshPurchaseReceipt(completion: @escaping ((PurchaseRestoreResult) -> Void)) {
		if !isPaid { return }
		validateTransactionReceipt { restoreResult in
			completion(restoreResult)
		}
	}
	
	private func validateTransactionReceipt(completion: @escaping ((PurchaseRestoreResult) -> ()) ) {
        let appleValidator = AppleReceiptValidator(service: storeKitService, sharedSecret: ImmutableValues.product.sharedSecret)
        SwiftyStoreKit.verifyReceipt(using: appleValidator) { result in
            switch result {
            case .success(let receipt):
                let productId = "com.branx.week"
                let purchaseResult = SwiftyStoreKit.verifySubscription(
                    ofType: .autoRenewable,
                    productId: productId,
                    inReceipt: receipt)
                switch purchaseResult {
                case .purchased(let expiryDate, let items):
                    print("Purchase Success: \(productId) is valid until \(expiryDate)\n\(items)\n")
                    self.isPaid = true
                case .expired(let expiryDate, let items):
                    print("\(productId) is expired since \(expiryDate)\n\(items)\n")
                    self.isPaid = false
                case .notPurchased:
                    print("The user has never purchased \(productId)")
                    self.isPaid = false
                }
            case .error(let error):
                print("Receipt verification failed: \(error.localizedDescription)")
                self.isPaid = false
            }
        }
    }
    
    func obtainItemData(with productId: String, complete: @escaping(SKProduct?)->()) {
        SwiftyStoreKit.retrieveProductsInfo([productId]) { result in
            complete(result.retrievedProducts.first)
        }
    }
    
    func getAllProducts(complete: @escaping (_ Success: [SKProduct]?,_ error: String?) -> () ) {
        var myProduct:[SKProduct] = []
        SwiftyStoreKit.retrieveProductsInfo(Set(ImmutableValues.product.renewableIDs)) { result in
            if let error = result.error {
                complete(nil,error.localizedDescription)
            } else {
                myProduct = result.retrievedProducts.sorted(by: { (product1, product2) -> Bool in
                    product1.subscriptionPeriod!.unit.rawValue > product2.subscriptionPeriod!.unit.rawValue
                })
                complete(myProduct,nil)
            }
         }
     }
    
    func purchaseProduct(productId: String, completion: @escaping((Bool)->())) {
        SwiftyStoreKit.purchaseProduct(productId) { (result) in
            var status = false
            switch result {
            case .success(let product):
                if product.needsFinishTransaction {
                    SwiftyStoreKit.finishTransaction(product.transaction)
                }
                status = true
                print("Purchase Success: \(product.productId) - Successful purchase!")
            case .error(let error):
                switch error.code {
                case .unknown:
                    print("Unknown error. Please contact support - Error: Unknown error occurred. Please contact support for assistance.")
                case .clientInvalid:
                    print("Not allowed to make the payment - Error: Payment not authorized.")
                case .paymentCancelled: break
                case .paymentInvalid:
                    print("The purchase identifier was invalid - Error: Invalid purchase identifier.")
                case .paymentNotAllowed:
                    print("The device is not allowed to make the payment - Error: Payment not allowed on this device.")
                case .storeProductNotAvailable:
                    print("The product is not available in the current storefront - Error: Product not available in the current storefront.")
                case .cloudServicePermissionDenied:
                    print("Access to cloud service information is not allowed - Error: Access to cloud service information denied.")
                case .cloudServiceNetworkConnectionFailed:
                    print("Could not connect to the network - Error: Network connection failed.")
                case .cloudServiceRevoked:
                    print("User has revoked permission to use this cloud service - Error: User revoked cloud service permission.")
                default: print((error as NSError).localizedDescription)
                }
            }
            self.isPaid = status
            completion(status)
        }
    }
}

extension Acquisitions: SHTFunnelManagerDelegate {
    func getProduct(_ productId: String, completion: @escaping((Bool) -> ())) {
        obtainItemData(with: productId) { product in
            completion(product != nil)
        }
    }

    func purchase(_ productId: String, completion: @escaping((Bool) -> ())) {
        purchaseProduct(productId: productId) { success in
            completion(success)
        }
    }

    func reopenProgram() {
        var window: UIWindow?
        
        if let windowScene = UIApplication.shared.windows.first?.windowScene {
            let contentView = ContentView()
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
        
        UserDefaults.standard.set(false, forKey: "isOboard")
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            RateReviewBranx.rateBranx()
        }
    }
}
