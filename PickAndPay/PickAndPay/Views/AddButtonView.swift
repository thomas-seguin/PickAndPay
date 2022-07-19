//
//  AddButtonView.swift
//  PickAndPay
//
//  Created by admin on 7/18/22.
//

import SwiftUI

struct AddButtonView: View {
    @EnvironmentObject var cartManager: CartManager
    var product: Product

    var body: some View {
        Button(action: {
            //DBHelper.dbHelper.insertToCart(username : product.productName as NSString, productId : product.productId, qty : 1)
            
            cartManager.addToCart(product: product)
            
        }, label: {
            Image(systemName: "plus")
            .padding(10)
            .foregroundColor(.white)
            .background(.blue)
            .cornerRadius(50)
        })

    }
}

struct AddButtonView_Previews: PreviewProvider {
    static var previews: some View {
        AddButtonView(product: products[0])
            .environmentObject(CartManager())

    }
}
