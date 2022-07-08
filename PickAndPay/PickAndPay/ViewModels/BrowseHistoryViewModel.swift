//
//  BrowseHistoryViewModel.swift
//  PickAndPay
//
//  Created by Philip Janzel Paradeza on 2022-07-08.
//

import Foundation
class BrowseHistoryViewModel{
    var userId = "UserTest" //assign username ffrom login here
    var browseHistory : [BrowseHistoryItem]{
        get{
            return DBHelper.dbHelper.getUserBrowseHistory(username: userId as NSString)
        }
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
    func removeFromBrowseHistory(id : Int){
        DBHelper.dbHelper.removeFromBrowseHistory(browseHistoryId: id)
    }
    func clearHistory(){
        DBHelper.dbHelper.clearUserBrowseHistory(username: userId as NSString)
    }
}
