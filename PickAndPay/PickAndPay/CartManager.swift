import Foundation
import SwiftUI

class CartManager: ObservableObject {
   // @Published private(set) var products: [Product] = []
    @Published var total = 0.0
    @Published var quantity = 0
    
    
    @Published var items : [CartItem]
    
    init(){
        
//        DBHelper.dbHelper.insertToCart(username: UserSingleton.userData.currentUsername as NSString, productId: 1, qty: 1)
//        DBHelper.dbHelper.insertToCart(username: UserSingleton.userData.currentUsername as NSString, productId: 2, qty: 1)

        items = DBHelper.dbHelper.getUserCart(username: UserSingleton.userData.currentUsername as NSString)
        intialCost()
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
            
            if amount == 0 {
                deleteFromCart(product: product)
            }


        }
    }
    
    func deleteFromCart(product: CartItem){
        if product.quantity >= 1{
            total = total - (product.cartProduct.price * Double(product.quantity))
        }
        DBHelper.dbHelper.removeFromCart(itemCartId: product.itemCartId)
        updateItems()
    }
    func updateItems(){
        items = DBHelper.dbHelper.getUserCart(username: UserSingleton.userData.currentUsername as NSString)

    }
    func intialCost(){
        var count = 0
        
        while (items.count > count && items.count != 0){
            total += items[count].cartProduct.price
            count += 1
        }

    }
    
}
