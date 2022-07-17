//
//  SignUpView.swift
//  PickAndPay
//
//  Created by admin on 7/6/22.
//

import SwiftUI

struct SignUpView: View {
    @StateObject private var signUpVM = SignUpViewModel()
    @State private var showOTP = false
    @EnvironmentObject var authentication: Authentication
    @State var sending: String = "my name is bob"
    @State private var isSecure = false
    @State private var validEmail = false
    @State private var validName = false
    @State private var validAddr = false
    @State private var validPhone = false
    @State private var validPass = false
    var body: some View {
        NavigationView{
            ZStack{
                Color.background
                
                RoundedRectangle(cornerRadius: 30, style: .continuous)
                    .foregroundStyle(.linearGradient(colors: [.white,.white], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .frame(width: 1000, height: 400)
                    .rotationEffect(.degrees(270))
                    .offset(y:250)
                
                
                VStack() {
                    Text("PickAndPay")
                        .foregroundColor(.text)
                        .font(.system(size: 40, weight: .bold, design: .rounded))
                        .offset(x: -80, y: -80)
                    VStack {
                        Text("Email")
                            .foregroundColor(.text)
                            .font(.system(size: 25, weight: .semibold, design: .rounded))
                            .offset(x: -145)
                        HStack{
                            Image(systemName: "envelope.fill")
                            TextField("Email Address", text:$signUpVM.userModel.userId)
                                .keyboardType(.emailAddress)
                                .textFieldStyle(.plain)
                                
                                .onChange(of: signUpVM.userModel.userId) { newValue in
                                    
                                    validEmail = signUpVM.checkEmail()
                                    
                                }
                            if validEmail {
                                Image(systemName: "checkmark.circle")
                                    .foregroundColor(.button)
                            } else {
                                Image(systemName: "xmark.circle")
                                    .foregroundColor(.red)
                            }
                        }
                        
                        Rectangle()
                            .frame(width: 350, height: 1)
                            .foregroundColor(.black)
                        
                        
                    }
                    VStack {
                        Text("Name")
                            .foregroundColor(.text)
                            .font(.system(size: 25, weight: .semibold, design: .rounded))
                            .offset(x: -145)
                        HStack{
                            Image(systemName: "person.fill")
                            TextField("Name", text: $signUpVM.userModel.name)
                                .onChange(of: signUpVM.userModel.name) { newValue in
                                    
                                    
                                   validName = signUpVM.checkName()
                                }
                                .textFieldStyle(.plain)
                            if validName {
                                Image(systemName: "checkmark.circle")
                                    .foregroundColor(.button)
                            } else {
                                Image(systemName: "xmark.circle")
                                    .foregroundColor(.red)
                            }
                            
                        }
                        
                        Rectangle()
                            .frame(width: 350, height: 1)
                            .foregroundColor(.black)
                        
                        
                       
                    }
                    VStack{
                        Text("Address")
                            .foregroundColor(.text)
                            .font(.system(size: 25, weight: .semibold, design: .rounded))
                            .offset(x: -130)
                        HStack{
                            Image(systemName: "house.fill")
                            TextField("Address", text: $signUpVM.userModel.address)
                                .onChange(of: signUpVM.userModel.address) { newValue in
                                   validAddr = signUpVM.checkAddr()
                                }
                                .textFieldStyle(.plain)
                            if validAddr {
                                Image(systemName: "checkmark.circle")
                                    .foregroundColor(.button)
                            } else {
                                Image(systemName: "xmark.circle")
                                    .foregroundColor(.red)
                            }
                            
                        }
                        
                        Rectangle()
                            .frame(width: 350, height: 1)
                            .foregroundColor(.black)
                        
                    }
                    
                    
                    VStack{
                        Text("Phone Number")
                            .foregroundColor(.text)
                            .font(.system(size: 25, weight: .semibold, design: .rounded))
                            .offset(x: -90)
                        HStack{
                            Image(systemName: "phone.fill")
                            TextField("Phone Number", text: $signUpVM.userModel.phoneNumber)
                                .keyboardType(.phonePad)
                                .onChange(of: signUpVM.userModel.phoneNumber) { newValue in
                                   validPhone = signUpVM.checkPhone()
                                }
                                .textFieldStyle(.plain)
                            if validPhone {
                                Image(systemName: "checkmark.circle")
                                    .foregroundColor(.button)
                            } else {
                                Image(systemName: "xmark.circle")
                                    .foregroundColor(.red)
                            }
                            
                        }
                        
                        Rectangle()
                            .frame(width: 350, height: 1)
                            .foregroundColor(.black)
                        
                        
                        
                    }
                    
                    
                    VStack{
                        Text("Password")
                            .foregroundColor(.text)
                            .font(.system(size: 25, weight: .semibold, design: .rounded))
                            .offset(x: -120)
                        HStack{
                            Button(action: {
                                isSecure.toggle()
                            }){
                                Image(systemName: "eye.slash.fill")
                                    .foregroundColor(.black)
                            }
                            if isSecure{
                                SecureField("Password", text: $signUpVM.userModel.password)
                                    .onChange(of: signUpVM.userModel.password) { newValue in
                                       validPass = signUpVM.checkPass()
                                        
                                    }
                                    .textFieldStyle(.plain)
                                
                            } else {
                                TextField("Password", text: $signUpVM.userModel.password)
                                    .onChange(of: signUpVM.userModel.password) { newValue in
                                     validPass = signUpVM.checkPass()
                                        
                                    }
                                    .textFieldStyle(.plain)
                                
                            }
                            if validPass {
                                Image(systemName: "checkmark.circle")
                                    .foregroundColor(.button)
                            } else {
                                Image(systemName: "xmark.circle")
                                    .foregroundColor(.red)
                            }
                            
                        }
                        
                        Rectangle()
                            .frame(width: 350, height: 1)
                            .foregroundColor(.black)
                        
                        
                    }
                    
                    if signUpVM.showProgressView {
                        ProgressView()
                    }
                    
                    NavigationLink(destination: OTPView()){
                        Text("Sign Up")
                            .bold()
                            .frame(width: 200, height: 40)
                            .background(RoundedRectangle(cornerRadius: 20,style: .continuous).fill(.linearGradient(colors:[.button,.button], startPoint: .top, endPoint: .bottomTrailing)))
                            .foregroundColor(.white)
                    }.simultaneousGesture(TapGesture().onEnded({
                        print("printing: \(signUpVM.userModel.userId)")
                        signUpVM.signUp()
                        
                        
                    }))
                    .offset(y:10)
                }
                .frame(width: 350, height: 600)
                .autocapitalization(.none)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .disabled(signUpVM.showProgressView)
                
            }
            .ignoresSafeArea()
        }
    }
}
struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
