//
//  Keyboard.swift
//  PickAndPay
//
//  Created by admin on 7/6/22.
//

import UIKit

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
