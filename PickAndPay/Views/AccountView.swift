//
//  AccountView.swift
//  PickAndPay
//
//  Created by admin on 7/17/22.
//

import SwiftUI

struct AccountView: View {
    @StateObject private var accountViewModel = AccountViewModel()
    @State private var name: String = "Thomas Seguin"
    @State private var newName: String = "Thomas Seguin"
    @State private var newAddr: String = "123 Main Street"
    var body: some View {
        ZStack{
            Color.background
        VStack{
            HStack(spacing: 30){
                Text("\(accountViewModel.userModel.name)")
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .padding()
                Spacer()
            }
            VStack(){
                HStack{
                    Text("Name")
                        .foregroundColor(.text)
                        .font(.system(size: 25, weight: .semibold, design: .rounded))
                        .padding()
                        
                    Spacer()
                }
                HStack{
                    Image(systemName: "person.fill")
                    TextField("Name", text: $accountViewModel.userModel.name)
                        .textFieldStyle(.plain)
                        .font(.system(size: 25))
                    
                }
                Rectangle()
                    .frame(width: 350, height: 1)
                    .foregroundColor(.black)
                
            }
            VStack(){
                HStack{
                    Text("Address")
                        .foregroundColor(.text)
                        .font(.system(size: 25, weight: .semibold, design: .rounded))
                        .padding()
                        
                    Spacer()
                }
                HStack{
                    Image(systemName: "house.fill")
                    TextField("Addres", text: $accountViewModel.userModel.address)
                        .textFieldStyle(.plain)
                        .font(.system(size: 25))
                    
                }
                Rectangle()
                    .frame(width: 350, height: 1)
                    .foregroundColor(.black)
                
            }
            VStack(){
                
                Button{
                    accountViewModel.updateUserDetails()
                } label: {
                    Text("Update Account")
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

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
