//
//  LoginView.swift
//  PickAndPay
//
//  Created by admin on 7/6/22.
//

import SwiftUI

struct LoginView: View {
    @State private var showingSheet = false
    @StateObject private var loginVM = LoginViewModel()
    @EnvironmentObject var authentication: Authentication
    var body: some View {
        VStack {
            Text("PickAndPay")
                .font(.largeTitle)
            TextField("Email Address", text: $loginVM.credentials.email)
                .keyboardType(.emailAddress)
            SecureField("Password", text: $loginVM.credentials.password)
            if loginVM.showProgressView {
                ProgressView()
            }
            Button("Login in") {
                loginVM.login { success in
                    print(success)
                    authentication.updateValidation(success: success)
                }
            }
            .disabled(loginVM.loginDisabled)
            .padding(.bottom,20)
            Spacer()
            Button("Create Account"){
                showingSheet.toggle()
            }
            .sheet(isPresented: $showingSheet) {
                SignUpView()
            }
        }
        .autocapitalization(.none)
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .padding()
        .disabled(loginVM.showProgressView)
        .alert(item: $loginVM.error) { error in
            Alert(title: Text("Invalid Login"), message: Text(error.localizedDescription))
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
