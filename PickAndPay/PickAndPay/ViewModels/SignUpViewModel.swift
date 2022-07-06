//
//  SignUpViewModel.swift
//  PickAndPay
//
//  Created by admin on 7/6/22.
//

import Foundation

class SignUpViewModel: ObservableObject {
    let userDB = DBHelper.dbHelper
    @Published var userModel = UserModel()
    @Published var showProgressView = false
    @Published var error: Authentication.AuthenticationError?
    
    var signUpDisabled: Bool {
        userModel.password.isEmpty || userModel.address.isEmpty || userModel.name.isEmpty || userModel.phoneNumber.isEmpty || userModel.userId.isEmpty
    }
    
    func signUp(){
        userDB.createDB()
        showProgressView = true
        userDB.insertUser(username: userModel.userId as NSString, password: userModel.password as NSString, name: userModel.name as NSString, address: userModel.address as NSString, number: userModel.phoneNumber as NSString)
        print("signed up")
        showProgressView = false
    }
}
