//
//  ProductDetailsViewModel.swift
//  PickAndPay
//
//  Created by Philip Janzel Paradeza on 2022-07-20.
//
import Foundation
class ProductDetailViewModel{
    var product : Product
    var userId = UserSingleton.userData.currentUsername
    var recommended : [Product]
    init(product : Product) {
        self.product = product
        let cat = product.category
        recommended = DBHelper.dbHelper.searchProducts(category: cat)
    }
    
    func getRatingString() -> String {
        let aveStr = String(format: "%.2f", product.averageRating)
        let count = String(product.reviewCount)
        let str = "Ave. Rating: " + aveStr + "/5.00 , " + count + " reviews"
        return str
    }
    func getPriceString() -> String{
        let price = "$" + String(format: "%.2f", product.price)
        return price
    }
    func getStock() -> String{
        let stock = String(product.stock) + " in stock"
        return stock
    }
    func isInStock() -> Bool{
        if(DBHelper.dbHelper.isInStock(productId: product.productId)){
            return true
        }
        else{
            return false
        }
    }
    func addToCart(){
        DBHelper.dbHelper.insertToCart(username: userId as NSString, productId: product.productId, qty: 1)
    }
    func addToWishList(){
        DBHelper.dbHelper.insertToWishList(userId: userId as NSString, productId: product.productId)
    }
}
