//
//  ProductRow.swift
//  PickAndPay
//
//  Created by admin on 7/6/22.
//

import SwiftUI

struct ProductRow: View {
    @EnvironmentObject var cartManager : CartManager
    var product: Product
    var body: some View {
        HStack(spacing:10){
            Image(product.productImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .cornerRadius(10)
                .scaledToFit()
            VStack {
                Text(product.productName)
                    .bold()
                //Spacer()
                Text(String(format: "$%.2f", product.price))
            }
            Spacer()
            //addPlus()
            HStack {
                Image(systemName: "minus").onTapGesture {
                    cartManager.quantity -= 1
                }.frame(width: 40, height: 40, alignment: .center)
                Text(String(cartManager.quantity))
                Image(systemName: "plus").onTapGesture {
                    cartManager.quantity += 1
                }.frame(width: 40, height: 40, alignment: .center)

            }
            Image(systemName: "trash")
                .foregroundColor(.white)
                .onTapGesture {
                    cartManager.removeFromCart(product: product)
                }
                .padding()
        }
        .background(.indigo, in: RoundedRectangle(cornerRadius: 1))
        .foregroundColor(.white)
        .frame(maxWidth: .infinity, maxHeight: 100, alignment: .leading)
    }

}

struct ProductRow_Previews: PreviewProvider {
    static var previews: some View {
        ProductRow(product: products[0])
            .environmentObject(CartManager(quantity: 0))
    }
}
