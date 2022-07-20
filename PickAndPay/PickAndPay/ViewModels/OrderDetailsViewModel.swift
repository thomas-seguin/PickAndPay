//
//  OrderDetailsViewModel.swift
//  PickAndPay
//
//  Created by Philip Janzel Paradeza on 2022-07-20.
//
import Foundation
class OrderDetailsViewModel{
    private var orderId : Int
    private var userId = UserSingleton.userData.currentUsername
    var orderDetails : Order{
        get{
            return DBHelper.dbHelper.getOrder(orderId: orderId)
        }
    }
    private var shipFee = 0.00
    private var itemTotalPrice = 0.00
    var recommended : [Product]{
        get{
            guard let cat = orderDetails.productOrders.first?.orderedProduct.category else{ return [Product]()}
            return DBHelper.dbHelper.searchProducts(category: cat)
        }
    }
    
    init(orderId : Int){
        self.orderId = orderId
    }
    
    func getOrderTotalQty() -> String{
        return "CDN$ \(String(format: "%.2f", orderDetails.totalPrice)) (\(orderDetails.numOfProducts) items)"
    }
    func getOrderStatus() -> String{
        return orderDetails.status.rawValue
    }
    func getItemTotal() -> String{
        for item in orderDetails.productOrders{
            itemTotalPrice += item.totalPrice
        }
        if(itemTotalPrice < 200){
            shipFee = 10.00
        }
        return "CDN$ \(String(format: "%.2f", itemTotalPrice))"
    }
    func getShipFee() -> String{
        return "CDN$ \(String(format: "%.2f", shipFee))"
    }
    func getBeforeTax() -> String{
        return "CDN$ \(String(format: "%.2f", itemTotalPrice + shipFee))"
    }
    func getGST() -> String{
        return "CDN$ \(String(format: "%.2f", itemTotalPrice * 0.05))"
    }
    func getTotal() -> String{
        return "CDN$ \(String(format: "%.2f", itemTotalPrice + itemTotalPrice * 0.05))"
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
