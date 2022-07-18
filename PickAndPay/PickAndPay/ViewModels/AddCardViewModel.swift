//
//  AddCardViewModel.swift
//  PickAndPay
//
//  Created by admin on 7/17/22.
//

import Foundation
class AddCardViewModel: ObservableObject{
    let cardDB = DBHelper.dbHelper
    let userDefaults = UserDefaults()
    @Published var cardModel = Card()
    
    func addCard(){
        let user = userDefaults.string(forKey: "username")
        cardDB.addCard(cardNumber: cardModel.cardNumber as NSString, address: cardModel.address as NSString, cardName: cardModel.cardName as NSString, username: user! as NSString)
    }
}
