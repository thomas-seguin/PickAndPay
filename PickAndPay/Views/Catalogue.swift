//
//  Catalogue.swift
//  PickAndPay
//
//  Created by admin on 7/6/22.
//

import SwiftUI

struct Catalogue: View {
    @State var selected = 0
    @EnvironmentObject var cartManager: CartManager
    var body: some View {
        NavigationView {
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
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
struct Catalogue_Previews: PreviewProvider {
    static var previews: some View {
        Catalogue()
            .environmentObject(CartManager(quantity: 1))
    }
}
