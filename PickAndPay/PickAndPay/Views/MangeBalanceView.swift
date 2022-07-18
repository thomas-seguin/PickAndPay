//
//  MangeBalanceView.swift
//  PickAndPay
//
//  Created by admin on 7/17/22.
//

import SwiftUI

struct MangeBalanceView: View {
    @State private var selection: String?
    @State private var refresh = false
    @StateObject private var manageBalance = ManageBalanceViewModel()
    @State private var funds = ""
    @State private var cards = [Card]()
    var body: some View {
        VStack{
        VStack(alignment: .leading){
            Text("Your Balance")
                .foregroundColor(.text)
                .font(.system(size: 40, weight: .bold, design: .rounded))
            Text("$\(manageBalance.getBalance(), specifier: "%.2f")")
                .foregroundColor(.hightlight)
                .font(.system(size: 25, weight: .semibold, design: .rounded))
            
        }
            HStack{
            Text("Add Funds")
                .foregroundColor(.text)
                .font(.system(size: 25, weight: .semibold, design: .rounded))
                .padding()
                Spacer()
        }
            VStack(){
                HStack{
                    Text("Dollar Amount")
                        .foregroundColor(.text)
                        .font(.system(size: 25, weight: .semibold, design: .rounded))
                        .padding()
                        
                    Spacer()
                }
                HStack{
                    Image(systemName: "dollarsign.circle.fill")
                    TextField("10.00", text: $funds)
                        .textFieldStyle(.plain)
                        .font(.system(size: 25))
                    
                }
                Rectangle()
                    .frame(width: 350, height: 1)
                    .foregroundColor(.black)
                
            }
            HStack{
                Text("Select Payment Method")
                    .foregroundColor(.text)
                    .font(.system(size: 25, weight: .semibold, design: .rounded))
                    .padding()
                    
                Spacer()
            }
            
            List(cards, selection: $selection){ card in
                Button{
                    selection = card.cardNumber
                    print("card number: \(selection)")
                } label:{
                    if card.cardNumber == selection{
                        CardRow(card: card)
                            .overlay(RoundedRectangle(cornerRadius: 16).stroke(.green, lineWidth: 4))
                    }else {
                CardRow(card: card)
                    }
                }
            }
            
            
            Button{
                manageBalance.updateBalance(amount: Double(funds)!)
                refresh.toggle()
            } label: {
                Text("Add Funds")
                    .bold()
                    .frame(width: 200, height: 40)
                    .background(RoundedRectangle(cornerRadius: 20,style: .continuous).fill(.linearGradient(colors:[.button,.button], startPoint: .top, endPoint: .bottomTrailing)))
                    .foregroundColor(.white)
            }
            Spacer()
        }
        .onAppear{
            cards = manageBalance.getCards()
        }
    }
}

struct MangeBalanceView_Previews: PreviewProvider {
    static var previews: some View {
        MangeBalanceView()
    }
}
