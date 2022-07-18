//
//  ProductCardView.swift
//  PickAndPay
//
//  Created by admin on 7/18/22.
//

import SwiftUI

struct ProductCardView: View {
    @EnvironmentObject var cartManager: CartManager
    var product: Product
    var body: some View {
        ZStack(alignment: .topTrailing) {
            ZStack(alignment: .bottom){
                
                Image(product.productImage)
                    .resizable()
                    .frame(width: 150, height: 200)
                    .scaledToFit()
                
                VStack{
                    Text(product.productName).bold()
                    Text(String( format: "$%.2f", product.price))
                        .font(.caption)
                }
        
                .padding(.leading)
                .frame(width: 150, alignment: .leading)
                .cornerRadius(10)
                .background(.indigo)
                .foregroundColor(.white)
                
            }
            .cornerRadius(20)
            .frame(width: 150, height: 200)
            
            AddButtonView(product: product)  //experimental
            /*Button(action: {
                cartManager.addToCart(product: product)
            }, label: {
                Image(systemName: "plus")
                .padding(10)
                .foregroundColor(.white)
                .background(.blue)
                .cornerRadius(50)
            })
            */

        }
    }

}

struct ProductCardView_Previews: PreviewProvider {
    static var previews: some View {
        ProductCardView(product: products[0])
            .environmentObject(CartManager(quantity: 0))
    }
}
