//
//  ManageBalanceViewModel.swift
//  PickAndPay
//
//  Created by admin on 7/17/22.
//

import Foundation
class ManageBalanceViewModel: ObservableObject {
    @Published var userModel = User()
    let userDefault = UserDefaults()
    let dbHelper = DBHelper.dbHelper
    
    func getCards() -> [Card]{
        let user = userDefault.string(forKey: "username") ?? "admin@admin.com"
        return dbHelper.getUserCards(username: user as NSString)
    }
    
    func getBalance() -> Double {
        let user = userDefault.string(forKey: "username") ?? "admin@admin.com"
        return dbHelper.getUserBalance(username: user as NSString)
    }
    
    func updateBalance(amount: Double){
        let user = userDefault.string(forKey: "username") ?? "admin@admin.com"
        let current = dbHelper.getUserBalance(username: user as NSString)
        dbHelper.updateUserBalance(username: user as NSString, balance:amount + current)
    }
    
    
}
