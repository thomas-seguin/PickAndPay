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
                Image(systemName: "minus.rectangle")
                    .resizable()
                    .frame(width: 20, height: 40, alignment: .center)
                    .onTapGesture {
                    cartManager.quantity -= 1
                }
                Text(String(cartManager.quantity))
                    .font(.largeTitle)
                    .frame(width: 20, height: 40, alignment: .center)
                Image(systemName: "plus.rectangle")
                    .resizable()
                    .frame(width: 20, height: 40, alignment: .center)
                    .onTapGesture {
                    cartManager.quantity += 1
                }
            }
            Image(systemName: "trash")
                .resizable()
                .frame(width: 20, height: 40, alignment: .center)
                .foregroundColor(.red)
                .onTapGesture {
                    cartManager.removeFromCart(product: product)
                }
                .padding()
        }
        .background(.white, in: RoundedRectangle(cornerRadius: 1))
        .foregroundColor(.black)
        .frame(maxWidth: .infinity, maxHeight: 100, alignment: .leading)
    }

}

struct ProductRow_Previews: PreviewProvider {
    static var previews: some View {
        ProductRow(product: products[0])
            .environmentObject(CartManager(quantity: 0))
    }
}
