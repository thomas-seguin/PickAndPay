//
//  ContentView.swift
//  PickAndPay
//
//  Created by admin on 6/27/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @ObservedObject var cartManager = CartManager(quantity: 0)

    var body: some View {
        
        TabView {
            CartView()
                .tabItem{Image(systemName: "cart")}
                .badge(cartManager.products.count)
            Catalogue()
               .tabItem{Image(systemName: "list.bullet")}
        }.environmentObject(cartManager)

    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(CartManager(quantity: 0))//.environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
