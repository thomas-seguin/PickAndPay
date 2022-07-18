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
    @State private var isShowingOTPView = false
    @State private var isShowingMainView = false
    @StateObject private var loginVM = LoginViewModel()
    @EnvironmentObject var authentication: Authentication
    var body: some View {
    
            ZStack{
                NavigationLink(destination: OTPView(), isActive: $isShowingOTPView) { EmptyView()}
                
                NavigationLink(destination: MainTabView(), isActive: $isShowingMainView) { EmptyView()}

                
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
                    
                    Text("Email")
                        .foregroundColor(.text)
                        .font(.system(size: 25, weight: .semibold, design: .rounded))
                        .offset(x: -145)
                    HStack{
                        Image(systemName: "envelope.fill")
                        TextField("Your Email Address", text: $loginVM.credentials.email)
                            .keyboardType(.emailAddress)
                            .foregroundColor(.text)
                            .textFieldStyle(.plain)
                    }
                    
                    Rectangle()
                        .frame(width: 350, height: 1)
                        .foregroundColor(.black)
                        .offset(y:-15)
                    
                    VStack{
                        Text("Password")
                            .foregroundColor(.text)
                            .font(.system(size: 25, weight: .semibold, design: .rounded))
                            .offset(x: -120)
                        HStack{
                            Button(action: {
                                print("clicked")
                            }){
                                Image(systemName: "eye.slash.fill")
                                    .foregroundColor(.black)
                            }
                            SecureField("Your Password", text: $loginVM.credentials.password)
                                .foregroundColor(.text)
                                .textFieldStyle(.plain)
                        }
                    }
                    
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
                            
                            if loginVM.isVerified(username: loginVM.credentials.email) == 0{
                                isShowingOTPView = true
                            } else {
                                //authentication.isValidated = true
                                isShowingMainView = true
                            }
                        }
                        
                    } label: {
                        Text("Login")
                            .bold()
                            .frame(width: 200, height: 40)
                            .background(RoundedRectangle(cornerRadius: 20,style: .continuous).fill(.linearGradient(colors:[.button,.button], startPoint: .top, endPoint: .bottomTrailing)))
                            .foregroundColor(.white)
                    }.disabled(loginVM.loginDisabled)
                        .offset(y: -30)
                    
                    Button{
                        showingSheet.toggle()
                    } label: {
                        Text("Dont have an account? Sign Up")
                            .bold()
                            .foregroundColor(.text)
                    }
                    .offset(y: 50)
                    .sheet(isPresented: $showingSheet) {
                        SignUpView()
                    }
                    
                    
                    
                }
                .frame(width: 350, height: 600)
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
