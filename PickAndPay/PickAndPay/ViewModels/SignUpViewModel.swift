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
    @Published var userModel = UserModel()
    @Published var showProgressView = false
    @Published var error: Authentication.AuthenticationError?
    @Published var isEmailValid = false
    @Published var isPhoneValid = false
    @Published var isPassValid = false
    @Published var isNameValid = false
    
    func checkEmail() {
        let emailResult = userModel.userId.range(of: emailPattern, options: .regularExpression)
        isEmailValid = (emailResult != nil)
        
    }
    
    func checkName() {
        let nameResult = userModel.name.range(of: textPattern, options: .regularExpression)
        isNameValid = (nameResult != nil)
        
    }
    
    func checkPass() {
        let passResult = userModel.password.range(of: passwordPattern, options: .regularExpression)
        isPassValid = (passResult != nil)
        
    }
    
    
    func checkPhone() {
        let phoneResult = userModel.phoneNumber.range(of: phonePattern, options: .regularExpression)
        isPhoneValid = (phoneResult != nil)
        
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
        showProgressView = true
        userDB.insertUser(username: userModel.userId as NSString, password: userModel.password as NSString, name: userModel.name as NSString, address: userModel.address as NSString, number: userModel.phoneNumber as NSString)
        print("signed up")
        showProgressView = false
        userModel = UserModel()
    }
}
