//
//  WishListViewModel.swift
//  PickAndPay
//
//  Created by Philip Janzel Paradeza on 2022-07-07.
//
import Foundation
class WishListViewModel{
    private var userId = UserSingleton.userData.currentUsername
    var wishList : [WishListItem]{
        get{
            return DBHelper.dbHelper.getUserWishList(username: userId as NSString)
        }
    }
    var recommended : [Product]{
        get{
            guard let cat = wishList.first?.wishProduct.category else { return [Product]() }
            return DBHelper.dbHelper.searchProducts(category: cat)
        }
    }
    init(){
        userId = UserSingleton.userData.currentUsername
    }
    func getUsername() -> String{
        return userId
    }
    func getRatingString(product : Product) -> String {
        let aveStr = String(format: "%.2f", product.averageRating)
        let count = String(product.reviewCount)
        let str = "Ave. Rating: " + aveStr + "/5.00 , " + count + " reviews"
        return str
    }
    func getPriceString(product : Product) -> String{
        let price = "$" + String(format: "%.2f", product.price)
        return price
    }
    
    func isInStock(product : Product) -> Bool{
        if(DBHelper.dbHelper.isInStock(productId: product.productId)){
            return true
        }
        else{
            return false
        }
    }
    
    func addToCart(item : WishListItem){
        DBHelper.dbHelper.insertToCart(username: userId as NSString, productId: item.wishProduct.productId, qty: 1)
        DBHelper.dbHelper.deleteWishListItem(WishListId: item.wishListId)
    }
    func removeFromWishList(id : Int){
        DBHelper.dbHelper.deleteWishListItem(WishListId: id)
    }
    
}
