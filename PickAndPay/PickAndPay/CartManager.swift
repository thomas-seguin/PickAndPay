//
//  CartManager.swift
//  PickAndPay
//
//  Created by admin on 7/6/22.
//

import Foundation
import SwiftUI

class CartManager: ObservableObject {
   // @Published private(set) var products: [Product] = []
    @Published var total = 0.0
    @Published var quantity = 0
    
    
    @Published var items : [CartItem]
    
    init(){
        DBHelper.dbHelper.createDB()
        //DBHelper.dbHelper.dropProductTable()
        //DBHelper.dbHelper.dropReviewTable()
        DBHelper.dbHelper.createTables()
        //InsertProductData.populate.populateCategories()
        DBHelper.dbHelper.clearUserCart(username: UserSingleton.userData.currentUsername as NSString)
                
        DBHelper.dbHelper.insertToCart(username: UserSingleton.userData.currentUsername as NSString, productId: 1, qty: 1)
        DBHelper.dbHelper.insertToCart(username: UserSingleton.userData.currentUsername as NSString, productId: 2, qty: 1)

        items = DBHelper.dbHelper.getUserCart(username: UserSingleton.userData.currentUsername as NSString)
        updateItems()
    }

    func addToCart(product: CartItem){
        //products.append(product)
        
        total = total + product.cartProduct.price
        var amount = product.quantity + 1
        print(amount)
        DBHelper.dbHelper.updateCartItemQty(qty: amount, itemCartId: product.itemCartId)
        updateItems()

    }
    func removeFromCart(product: CartItem){
        //products = products.filter{$0.productId != product.productId}
        if product.quantity > 0 {
            total = total - product.cartProduct.price
            var amount = product.quantity - 1
            print(amount)
            DBHelper.dbHelper.updateCartItemQty(qty: amount, itemCartId: product.itemCartId)
            updateItems()


        }
    }
    
    func deleteFromCart(product: CartItem){
        //items = items.filter{$0.productId != product.productId}
        DBHelper.dbHelper.removeFromCart(itemCartId: product.itemCartId)
        updateItems()
    }
    func updateItems(){
        var count = 0
        items = DBHelper.dbHelper.getUserCart(username: UserSingleton.userData.currentUsername as NSString)
        while (items.count > count && items.count != 0){
            total += items[count].cartProduct.price
            count += 1
        }

    }
}
