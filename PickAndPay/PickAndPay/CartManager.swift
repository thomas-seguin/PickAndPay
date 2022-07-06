//
//  CartManager.swift
//  PickAndPay
//
//  Created by admin on 7/6/22.
//

import Foundation

class CartManager: ObservableObject {
    @Published private(set) var products: [Product] = []
    @Published private(set) var total = 0.0
    @Published var quantity = 0
    
    init(quantity: Int){
        self.quantity = quantity > 0 ? quantity : 0
    }
    
    func addToCart(product: Product){
        products.append(product)
        total += product.price
    }
    func removeFromCart(product: Product){
        products = products.filter{$0.productId != product.productId}
        total -= product.price
    }
}
