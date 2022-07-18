//
//  AccountViewModel.swift
//  PickAndPay
//
//  Created by admin on 7/17/22.
//

import Foundation
class AccountViewModel: ObservableObject {
    @Published var userModel = User()
    let userDefault = UserDefaults()
    let dbHelper = DBHelper.dbHelper
    
    init(){
        let user = userDefault.string(forKey: "username")
        userModel = dbHelper.getUser(username: user! as NSString)
    }
    
    func updateUserDetails(){
        dbHelper.updateUser(username: userModel.userId as NSString, password: userModel.password as NSString, name: userModel.name as NSString, address: userModel.address as NSString, number: userModel.phoneNumber as NSString, balance: userModel.currentBalance)
    }
    
    
}
