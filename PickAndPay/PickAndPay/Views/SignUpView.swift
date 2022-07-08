//
//  SignUpView.swift
//  PickAndPay
//
//  Created by admin on 7/6/22.
//

import SwiftUI

struct SignUpView: View {
    @StateObject private var signUpVM = SignUpViewModel()
    @EnvironmentObject var authentication: Authentication
    var body: some View {
        
            VStack {
                Text("PickAndPay")
                    .font(.largeTitle)
                VStack {
                    TextField("Email Address", text:$signUpVM.userModel.userId)
                        .keyboardType(.emailAddress)
                        .onChange(of: signUpVM.userModel.userId) { newValue in
                            signUpVM.checkEmail()
                        }
                    Text(signUpVM.emailPrompt)
                }
                TextField("Name", text: $signUpVM.userModel.name)
                TextField("Address", text: $signUpVM.userModel.address)
                TextField("Phone Number", text: $signUpVM.userModel.phoneNumber)
                    .keyboardType(.phonePad)
                    .onChange(of: signUpVM.userModel.phoneNumber) { newValue in
                        signUpVM.checkPhone()
                    }
                Text(signUpVM.phonePrompt)
                SecureField("Password", text: $signUpVM.userModel.password)
                if signUpVM.showProgressView {
                    ProgressView()
                }
                Button("Sign Up") {
                    signUpVM.signUp()
                    authentication.isValidated = true
                }
                .disabled(signUpVM.signUpDisabled)
                .padding(.bottom,20)
                Spacer()
            }
            .autocapitalization(.none)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
            .disabled(signUpVM.showProgressView)
           
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
