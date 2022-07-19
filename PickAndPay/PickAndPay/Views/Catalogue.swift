//
//  Catalogue.swift
//  PickAndPay
//
//  Created by admin on 7/6/22.
//

import SwiftUI

struct Catalogue: View {
    @EnvironmentObject var cartManager: CartManager
    var body: some View {
      
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))]){
                    ForEach(products, id: \.productId){
                        product in
                        ProductCardView(product: product)
                            .environmentObject(cartManager)
                        RatingView()
                    }
                    .padding(.bottom,60)
                
                }
                .padding()
            }
            .background(.brown)
            .navigationTitle("Shoes")
        }
       
    }


struct Catalogue_Previews: PreviewProvider {
    static var previews: some View {
        Catalogue()
            .environmentObject(CartManager())
    }
}
