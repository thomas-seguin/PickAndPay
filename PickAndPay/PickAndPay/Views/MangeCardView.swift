//
//  MangeCardView.swift
//  PickAndPay
//
//  Created by admin on 7/17/22.
//

import SwiftUI

struct CardRow: View {
    var card: Card
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 16)
                .foregroundColor(.blue)
            
            Image("visa")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .offset(x: -100, y: -60)
            VStack{
                Spacer()
                HStack{
                    
                    Text("\(card.cardName)")
                        .foregroundColor(.white)
                        .font(.system(size: 20, weight: .semibold, design: .rounded))
                    Spacer()
                }
                
                HStack{
                    Text("\(card.cardNumber)")
                        .foregroundColor(.white)
                        .font(.system(size: 20, weight: .semibold, design: .rounded))
                    Spacer()
                }
            }
        }
        .frame(width: 300, height: 200)
    }
}

struct MangeCardView: View {
    @State private var cards = [Card]()
    @StateObject private var manageCardModel = MangageCardViewModel()
    var body: some View {
       
            
            VStack{
                HStack{
                    Spacer()
                    NavigationLink(destination: AddCardView()){
                        Text("Add Card")
                            .font(.system(size: 25, weight: .semibold, design: .rounded))
                    }
                    .offset(x: -20, y: -20)
                }
                HStack{
                    Text("My Cards")
                        .font(.system(size: 35, weight: .bold, design: .rounded))
                        .padding()
                    
                    
                    
                    Spacer()
                }
                List(cards) { card in
                    CardRow(card: card)
                }
                .frame( alignment: .center)
                Spacer()
            }
        
        .onAppear{
            print("appearing")
            cards = manageCardModel.getCards()
        }
    }
}

struct MangeCardView_Previews: PreviewProvider {
    static var previews: some View {
        MangeCardView()
        CardRow(card: Card(id: 1, cardNumber: "123 456 7890", address: "123 Main Street", name: "Adam Smith", userId: "admin@admin.com"))
    }
}
