//
//  AccountView.swift
//  PickAndPay
//
//  Created by admin on 7/17/22.
//

import SwiftUI

struct AccountView: View {
    @State private var name: String = "Thomas Seguin"
    @State private var newName: String = "Thomas Seguin"
    @State private var newAddr: String = "123 Main Street"
    var body: some View {
        VStack{
            HStack(spacing: 30){
                Text("\(name)")
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
                    TextField("Name", text: $newName)
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
                    TextField("Addres", text: $newAddr)
                        .textFieldStyle(.plain)
                        .font(.system(size: 25))
                    
                }
                Rectangle()
                    .frame(width: 350, height: 1)
                    .foregroundColor(.black)
                
            }
            VStack(){
                HStack{
                    Text("Balance")
                        .foregroundColor(.text)
                        .font(.system(size: 25, weight: .semibold, design: .rounded))
                        .padding()
                        
                    Spacer()
                }
                HStack{
                    Image(systemName: "dollarsign.circle.fill")
                    Text("10.00")
                        .font(.system(size: 25))
                    Spacer()
                    
                }
                Rectangle()
                    .frame(width: 350, height: 1)
                    .foregroundColor(.black)
                    .offset(y: -10)
                
                Button{
                   
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
        .frame(width: 350)
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
