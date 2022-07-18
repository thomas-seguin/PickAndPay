//
//  MangeCardViewModel.swift
//  PickAndPay
//
//  Created by admin on 7/17/22.
//

import Foundation
class MangageCardViewModel: ObservableObject {
    let userDefaults = UserDefaults()
    let cardDB = DBHelper.dbHelper
    
    func getCards() -> [Card]{
        let username = userDefaults.string(forKey: "username")
        
        return cardDB.getUserCards(username: username! as NSString)
    }
}
