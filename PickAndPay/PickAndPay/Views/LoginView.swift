//
//  LoginView.swift
//  PickAndPay
//
//  Created by admin on 7/6/22.
//

import SwiftUI

struct LoginView: View {
    @State private var showingSheet = false
    @State private var rememberMe = false
    @StateObject private var loginVM = LoginViewModel()
    @EnvironmentObject var authentication: Authentication
    var body: some View {
        ZStack{
            Color.background
            
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .foregroundStyle(.linearGradient(colors: [.white,.white], startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(width: 1000, height: 400)
                .rotationEffect(.degrees(270))
                .offset(y:350)
            
            VStack(spacing: 20) {
                Text("PickAndPay")
                    .foregroundColor(.text)
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                    .offset(x: -80, y: -120)
                
                TextField("Email Address", text: $loginVM.credentials.email)
                    .keyboardType(.emailAddress)
                    .foregroundColor(.text)
                    .textFieldStyle(.plain)
                
                Rectangle()
                    .frame(width: 350, height: 1)
                    .foregroundColor(.black)
                    .offset(y:-15)
                
                
                SecureField("Password", text: $loginVM.credentials.password)
                    .foregroundColor(.text)
                    .textFieldStyle(.plain)
                
                Rectangle()
                    .frame(width: 350, height: 1)
                    .foregroundColor(.black)
                    .offset(y:-15)
                
                
                if loginVM.showProgressView {
                    ProgressView()
                }
                Toggle("Remember Me",isOn: $rememberMe)
                    .onChange(of: rememberMe) { newValue in
                        loginVM.rememberMe(remember: rememberMe)
                    }
                    .offset(y: -25)
                
                Button {
                    
                    loginVM.login { success in
                        print(success)
                        authentication.updateValidation(success: success)
                    }
                    
                } label: {
                    Text("Login")
                        .bold()
                        .frame(width: 200, height: 40)
                        .background(RoundedRectangle(cornerRadius: 10,style: .continuous).fill(.linearGradient(colors:[.button,.button], startPoint: .top, endPoint: .bottomTrailing)))
                        .foregroundColor(.white)
                }.disabled(loginVM.loginDisabled)
                
                Button{
                    showingSheet.toggle()
                    
                } label: {
                    Text("Dont have an account? Sign Up")
                        .bold()
                        .foregroundColor(.text)
                }
                .sheet(isPresented: $showingSheet) {
                    SignUpView()
                }
            }
            .frame(width: 350)
            .autocapitalization(.none)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
            .disabled(loginVM.showProgressView)
            .alert(item: $loginVM.error) { error in
                Alert(title: Text("Invalid Login"), message: Text(error.localizedDescription))
            }
        }
        .ignoresSafeArea()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
