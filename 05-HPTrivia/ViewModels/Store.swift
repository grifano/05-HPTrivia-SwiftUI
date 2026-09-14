//
//  Store.swift
//  05-HPTrivia
//
//  Created by sorlenko on 14/09/2026.
//

import StoreKit

@MainActor
@Observable
class Store {
    var products: [Product] = []
    var purchased = Set<String>()
    
    private var updates: Task<Void, Never>? = nil
    
    init() {
        updates = watchForUpdates()
    }
    
    // Load our producst
    func loadProducts() async {
        do {
            products = try await Product.products(for: ["hp4","hp5","hp6","hp7"])
            products.sort {
                $0.displayName < $1.displayName
            }
        } catch {
            print("Unable to load products: \(error)")
        }
    }
    
    // Purchase product
    func purchase(_ product: Product) async {
        do {
            let result = try await product.purchase()
            
            switch result {
            case .success(let verificationResult):
            // Purchase successful, but now we need to verify receipt and transaction.
                switch verificationResult {
                case .unverified(let signedType, let verificationError):
                    print("Error on \(signedType): \(verificationError)")
                case .verified(let signedType):
                    purchased.insert(signedType.productID)
                    
                    await signedType.finish()
                }
            case .userCancelled:
            // User cancelled or parent disapproved child's purchase request.
                break // For this case it not need, but it can be usefull in future. Like you can use it for marketing porpouse. To remind user about purchase.
            case .pending:
            // Waiting for some sort of approval. Like a child waiting for approval from a parents.
                break
            @unknown default:
                break
            }
            
        } catch {
            print("Unable to purchase a product: \(error)")
        }
    }
    
    // Check for purchased products
    private func checkPurchased() async {
        purchased.removeAll()
        
        for await entitlement in Transaction.currentEntitlements {
            switch entitlement {
            case .unverified(let signedType, let verificationError):
                print("Error on \(signedType): \(verificationError)")
                
            case .verified(let transaction):
                if transaction.revocationDate == nil {
                    purchased.insert(transaction.productID)
                } else {
                    purchased.remove(transaction.productID)
                }
            }
        }
    }
    
    // Update product purchase
    private func watchForUpdates() -> Task<Void, Never> {
        Task(priority: .background) {
            for await _ in Transaction.updates {
                await checkPurchased()
            }
        }
    }
    
}
