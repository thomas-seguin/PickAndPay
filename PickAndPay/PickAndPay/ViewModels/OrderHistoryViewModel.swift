//
//  OrderHistoryViewModel.swift
//  PickAndPay
//
//  Created by Philip Janzel Paradeza on 2022-07-20.
//
import Foundation
class OrderHistoryViewModel{
    private var userId = UserSingleton.userData.currentUsername
    var orderHistory : [Order]{
        get{
            return DBHelper.dbHelper.getUserOrders(username: userId as NSString)
        }
    }
    
    var recommended : [Product]{
        get{
            guard let cat = orderHistory.first?.productOrders.first?.orderedProduct.category else{ return [Product]()}
            return DBHelper.dbHelper.searchProducts(category: cat)
        }
    }
    
    init(){
        userId = UserSingleton.userData.currentUsername
    }
    
    func getFirstImage(thisOrder : Order) -> String{
        return thisOrder.productOrders.first?.orderedProduct.productImage ?? ""
    }
    
    func removeFromOrderHistory(orderId : Int){
        DBHelper.dbHelper.deleteOrderDetails(orderId: orderId)
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
   
}
