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
    
    // Check for purchased products
    
    // Update product purchase
    
    
}
