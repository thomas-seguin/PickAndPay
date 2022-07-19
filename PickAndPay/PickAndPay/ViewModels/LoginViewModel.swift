//
//  LoginViewModel.swift
//  PickAndPay
//
//  Created by admin on 7/6/22.
//

import Foundation

class LoginViewModel: ObservableObject{
    let userSingleton = UserSingleton.userData
    let userDB = DBHelper.dbHelper
    let userDefaults = UserDefaults()
    private var rememberMe: Bool = false
    @Published var credentials = Credentials()
    @Published var showProgressView = false
    @Published var error: Authentication.AuthenticationError?
    
    func isVerified(username: String) -> Int {
        return userDB.getVerified(username: username as NSString)
    }
    
    var loginDisabled: Bool {
        credentials.email.isEmpty || credentials.password.isEmpty
    }
    
    func rememberMe(remember: Bool){
        if remember{
            rememberMe = true
        } else {
            rememberMe = false
        }
    }
    
    func login(completion: @escaping (Bool) -> Void){
        userDB.createDB()
        userDB.createTables()
        showProgressView = true
        let result = userDB.isPassCorrect(username: credentials.email as NSString, password: credentials.password as NSString)
        
        switch result {
        case true:
            userSingleton.currentUsername = credentials.email
            userDefaults.set(credentials.email, forKey: "username")
            if rememberMe {
                userDefaults.set(true, forKey: "remember")
            } else {
                userDefaults.set(false, forKey: "remember")
            }
            completion(true)
        
        case false:
            credentials = Credentials()
            completion(false)
    }
    }
}
