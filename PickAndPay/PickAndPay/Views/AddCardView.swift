

//
//  AccountView.swift
//  PickAndPay
//
//  Created by admin on 7/17/22.
//

import SwiftUI

struct AddCardView: View {
    @StateObject private var addCardViewModel = AddCardViewModel()
    @State private var name: String = "Thomas Seguin"
    @State private var newEmail: String = "Thomas Seguin"
    @State private var newPass: String = "123456789"
    var body: some View {
        ZStack{
            Color.background
        VStack{
            HStack(spacing: 30){
                Text("Add New Card")
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .padding()
                Spacer()
            }
            VStack(){
                HStack{
                    Text("Card Number")
                        .foregroundColor(.text)
                        .font(.system(size: 25, weight: .semibold, design: .rounded))
                        .padding()
                        
                    Spacer()
                }
                HStack{
                    Image(systemName: "creditcard.fill")
                    TextField("Card Number", text: $addCardViewModel.cardModel.cardNumber)
                        .textFieldStyle(.plain)
                        .font(.system(size: 25))
                    
                }
                Rectangle()
                    .frame(width: 350, height: 1)
                    .foregroundColor(.black)
                
            }
            VStack(){
                HStack{
                    Text("Billing Address")
                        .foregroundColor(.text)
                        .font(.system(size: 25, weight: .semibold, design: .rounded))
                        .padding()
                        
                    Spacer()
                }
                HStack{
                    Image(systemName: "house.fill")
                    TextField("Billing Address", text: $addCardViewModel.cardModel.address)
                        .textFieldStyle(.plain)
                        .font(.system(size: 25))
                    
                }
                Rectangle()
                    .frame(width: 350, height: 1)
                    .foregroundColor(.black)
                
            }
            VStack(){
                HStack{
                    Text("Card Holder Name")
                        .foregroundColor(.text)
                        .font(.system(size: 25, weight: .semibold, design: .rounded))
                        .padding()
                        
                    Spacer()
                }
                HStack{
                    Image(systemName: "person.fill")
                    TextField("Name", text: $addCardViewModel.cardModel.cardName)
                        .textFieldStyle(.plain)
                        .font(.system(size: 25))
                    
                }
                Rectangle()
                    .frame(width: 350, height: 1)
                    .foregroundColor(.black)
                
            }

            VStack(){
                
                Button{
                    addCardViewModel.addCard()
                } label: {
                    Text("Add Card")
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

struct AddCardView_Previews: PreviewProvider {
    static var previews: some View {
        AddCardView()
    }
}
