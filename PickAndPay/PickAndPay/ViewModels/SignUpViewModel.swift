//
//  SignUpViewModel.swift
//  PickAndPay
//
//  Created by admin on 7/6/22.
//

import Foundation

class SignUpViewModel: ObservableObject {
    let userDB = DBHelper.dbHelper
    let emailPattern = #"^\S+@\S+\.\S+$"#
    let phonePattern = #"^(\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]\d{3}[\s.-]\d{4}$"#
    let passwordPattern = #"(?=.{8,})"#
    let textPattern = #"^[a-zA-Z ]*$"#
    let userDefauts = UserDefaults()
    @Published var userModel = UserModel()
    @Published var showProgressView = false
    @Published var error: Authentication.AuthenticationError?
    @Published var isEmailValid = false
    @Published var isPhoneValid = false
    @Published var isPassValid = false
    @Published var isNameValid = false
    @Published var isAddrValid = false
    
    func checkEmail() ->Bool {
        let emailResult = userModel.userId.range(of: emailPattern, options: .regularExpression)
        isEmailValid = (emailResult != nil)
        return isEmailValid
        
    }
    
    func checkName() -> Bool {
        let nameResult = userModel.name.range(of: textPattern, options: .regularExpression)
        isNameValid = (nameResult != nil)
        return isNameValid
        
    }
    
    func checkAddr() -> Bool{
        let addrResult = userModel.address.range(of: textPattern, options: .regularExpression)
       isAddrValid = (addrResult != nil)
        return isAddrValid
    }
    
    func checkPass() -> Bool {
        let passResult = userModel.password.range(of: passwordPattern, options: .regularExpression)
        isPassValid = (passResult != nil)
        return isPassValid
        
    }
    
    
    func checkPhone() -> Bool {
        let phoneResult = userModel.phoneNumber.range(of: phonePattern, options: .regularExpression)
        isPhoneValid = (phoneResult != nil)
        return isPhoneValid
        
    }
    
    var signUpDisabled: Bool {
        userModel.password.isEmpty || userModel.address.isEmpty || userModel.name.isEmpty || isPhoneValid || isEmailValid
    }
    
    
    var passPrompt: String {
        isPassValid ? "" : "Please Enter a valid Password"
    }
    
    var namePrompt: String {
        isNameValid ? "" : "Please Enter a valid Name"
    }
    
    var emailPrompt: String {
        if isEmailValid {
           return ""
        } else {
          return  "Enter a valid email address"
    }
    }
    
    var phonePrompt: String {
        isPhoneValid ? "" : "Please Enter a valid Phone Number"
    }
    
    func signUp(){
        userDB.createDB()
        userDB.createTables()
        userDefauts.set(userModel.userId, forKey: "username")
        let name = userDefauts.string(forKey: "username")
        showProgressView = true
        userDB.insertUser(username: userModel.userId as NSString, password: userModel.password as NSString, name: userModel.name as NSString, address: userModel.address as NSString, number: userModel.phoneNumber as NSString)
        print("signed up")
        showProgressView = false
        userModel = UserModel()
        print("After Sign UP: --------")
        print(userDB.getUser(username: name! as NSString))
    }
}
