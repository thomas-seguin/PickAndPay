//
//  UserSingleton.swift
//  PickAndPay
//
//  Created by Philip Janzel Paradeza on 2022-07-08.
//

import Foundation
class UserSingleton{
    let userDefaults = UserDefaults()
    static var userData = UserSingleton()
    var currentUsername = "" // set the successfully loggedin username here at login/register for the Navbar's Username
    
    //when user opens a product details screen,
    //if (UserSingleton.browseHistorySwitch == true), call DBHelper.dbHelper.productBrowsed(productId : Int, username : NSString)
    //else, do nothing
    var browseHistorySwitch : Bool{
        get{
            let key = currentUsername+"_BrowseSwitch"
            var thisBool : Bool
            thisBool = userDefaults.bool(forKey: key)
            return thisBool
        }
        set(newBool){
            let key = currentUsername+"_BrowseSwitch"
            userDefaults.set(newBool, forKey: key)
        }
    }
    private init(){
        
    }
}
