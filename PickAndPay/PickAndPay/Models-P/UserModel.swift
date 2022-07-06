//
//  UserModel.swift
//  PickAndPay
//
//  Created by admin on 7/6/22.
//

import Foundation

struct UserModel: Codable {
    var userId: String = ""
    var password: String = ""
    var name: String = ""
    var address: String = ""
    var phoneNumber: String = ""
}
