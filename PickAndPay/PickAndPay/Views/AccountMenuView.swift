//
//  AccountMenuView.swift
//  PickAndPay
//
//  Created by admin on 7/17/22.
//

import SwiftUI

struct AccountMenuView: View {
    var body: some View {
        NavigationView{
        ZStack{
            VStack{
                HStack{
                    Text("Account Settings")
                        .font(.system(size: 40, weight: .bold, design: .rounded))
                        .padding()
                    Spacer()
                }
                HStack{
                    Text("Account")
                        .padding()
                        .font(.system(size: 25, weight: .semibold, design: .rounded))
                    Spacer()
                }
                NavigationLink(destination: AccountView()){
                    HStack{
                    Text("My Profile")
                        .foregroundColor(.text)
                        .padding(.trailing, 250)
                        .font(.system(size: 20))
                        
                        Image(systemName: "chevron.right")
                        
                    }
                    .padding(.top, 10)
                    .padding(.bottom, 10)
                    .padding(.leading, 10)
                    .padding(.trailing, 10)
                    .overlay(RoundedRectangle(cornerRadius: 16).stroke(.gray, lineWidth: 2))
                }
                
                NavigationLink(destination: AccountView()){
                    HStack{
                    Text("Login & Security")
                        .foregroundColor(.text)
                        .padding(.trailing, 195)
                        .font(.system(size: 20))
                        
                        Image(systemName: "chevron.right")
                        
                    }
                    .padding(.top, 10)
                    .padding(.bottom, 10)
                    .padding(.leading, 10)
                    .padding(.trailing, 10)
                    .overlay(RoundedRectangle(cornerRadius: 16).stroke(.gray, lineWidth: 2))
                }
                
                NavigationLink(destination: AccountView()){
                    HStack{
                    Text("Manage Credit Cards")
                        .foregroundColor(.text)
                        .padding(.trailing, 150)
                        .font(.system(size: 20))
                        
                        Image(systemName: "chevron.right")
                        
                    }
                    .padding(.top, 10)
                    .padding(.bottom, 10)
                    .padding(.leading, 10)
                    .padding(.trailing, 10)
                    .overlay(RoundedRectangle(cornerRadius: 16).stroke(.gray, lineWidth: 2))
                }
                
                NavigationLink(destination: AccountView()){
                    HStack{
                    Text("Sign Out")
                        .foregroundColor(.text)
                        .padding(.trailing, 260)
                        .font(.system(size: 20))
                        
                        Image(systemName: "chevron.right")
                        
                    }
                    .padding(.top, 10)
                    .padding(.bottom, 10)
                    .padding(.leading, 10)
                    .padding(.trailing, 10)
                    .overlay(RoundedRectangle(cornerRadius: 16).stroke(.gray, lineWidth: 2))
                }
                
                
                HStack{
                    Text("Orders")
                        .padding()
                        .font(.system(size: 25, weight: .semibold, design: .rounded))
                    Spacer()
                }
                NavigationLink(destination: AccountView()){
                    HStack{
                    Text("Order History")
                        .foregroundColor(.text)
                        .padding(.trailing, 200)
                        .font(.system(size: 20))
                        
                        Image(systemName: "chevron.right")
                        
                    }
                    .padding(.top, 10)
                    .padding(.bottom, 10)
                    .padding(.leading, 10)
                    .padding(.trailing, 10)
                    .overlay(RoundedRectangle(cornerRadius: 16).stroke(.gray, lineWidth: 2))
                }
                Spacer()
            }
        }
    }
        .background(.white)
    }
}

struct AccountMenuView_Previews: PreviewProvider {
    static var previews: some View {
        AccountMenuView()
    }
}
