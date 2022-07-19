//
//  TabViewModel.swift
//  PickAndPay
//
//  Created by admin on 7/18/22.
//

import Foundation
class TabViewModel: ObservableObject {
    
    func checkRemember() -> Bool {
        let check = UserDefaults.standard.bool(forKey: "remember")
         
         return check
        
    }
}
