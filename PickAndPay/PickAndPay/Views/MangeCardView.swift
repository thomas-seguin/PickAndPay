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
        Text("Card Number: \(card.cardNumber)")
    }
}

struct MangeCardView: View {
    @State private var cards = [Card]()
    @StateObject private var manageCardModel = MangageCardViewModel()
    var body: some View {
        NavigationView{
            
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
            Spacer()
        }
    }
        .onAppear{
            cards = manageCardModel.getCards()
        }
}
}

struct MangeCardView_Previews: PreviewProvider {
    static var previews: some View {
        MangeCardView()
    }
}
