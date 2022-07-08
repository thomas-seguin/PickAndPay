//
//  LoginViewModel.swift
//  PickAndPay
//
//  Created by admin on 7/6/22.
//

import Foundation

class LoginViewModel: ObservableObject{
    let userDB = DBHelper.dbHelper
    @Published var credentials = Credentials()
    @Published var showProgressView = false
    @Published var error: Authentication.AuthenticationError?
    
    var loginDisabled: Bool {
        credentials.email.isEmpty || credentials.password.isEmpty
    }
    
    func rememberMe(remember: Bool){
        if remember{
        print("remembered")
        } else {
            print("no")
        }
    }
    
    func login(completion: @escaping (Bool) -> Void){
        userDB.createDB()
        userDB.createTables()
        showProgressView = true
        let result = userDB.isPassCorrect(username: credentials.email as NSString, password: credentials.password as NSString)
        
        switch result {
        case true:
            completion(true)
        
        case false:
            credentials = Credentials()
            completion(false)
    }
    }
}
