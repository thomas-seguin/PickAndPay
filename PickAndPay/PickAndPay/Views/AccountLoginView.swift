
//
//  AccountView.swift
//  PickAndPay
//
//  Created by admin on 7/17/22.
//

import SwiftUI

struct AccountLoginView: View {
    @State private var name: String = "Thomas Seguin"
    @State private var newEmail: String = "Thomas Seguin"
    @State private var newPass: String = "123456789"
    var body: some View {
        ZStack{
            Color.background
        VStack{
            HStack(spacing: 30){
                Text("Login Settings")
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .padding()
                Spacer()
            }
            VStack(){
                HStack{
                    Text("Email")
                        .foregroundColor(.text)
                        .font(.system(size: 25, weight: .semibold, design: .rounded))
                        .padding()
                        
                    Spacer()
                }
                HStack{
                    Image(systemName: "envelope.fill")
                    TextField("Name", text: $newEmail)
                        .textFieldStyle(.plain)
                        .font(.system(size: 25))
                    
                }
                Rectangle()
                    .frame(width: 350, height: 1)
                    .foregroundColor(.black)
                
            }
            VStack(){
                HStack{
                    Text("Password")
                        .foregroundColor(.text)
                        .font(.system(size: 25, weight: .semibold, design: .rounded))
                        .padding()
                        
                    Spacer()
                }
                HStack{
                    Image(systemName: "eye.slash.fill")
                    SecureField("Update Password", text: $newPass)
                        .textFieldStyle(.plain)
                        .font(.system(size: 25))
                    
                }
                Rectangle()
                    .frame(width: 350, height: 1)
                    .foregroundColor(.black)
                
            }
            VStack(){
                
                Button{
                   
                } label: {
                    Text("Update Login")
                        .bold()
                        .frame(width: 200, height: 40)
                        .background(RoundedRectangle(cornerRadius: 20,style: .continuous).fill(.linearGradient(colors:[.button,.button], startPoint: .top, endPoint: .bottomTrailing)))
                        .foregroundColor(.white)
                }
                
                HStack {
                    
                }
                
            }
        }
        .padding()
        .frame(width: 375, height: 500 )
        .cornerRadius(16)
        .background(.white
        )
    }
        .ignoresSafeArea()
}
}

struct AccountLoginView_Previews: PreviewProvider {
    static var previews: some View {
        AccountLoginView()
    }
}
