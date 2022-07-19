//
//  TabView.swift
//  PickAndPay
//
//  Created by admin on 7/17/22.
//

import SwiftUI

struct MainTabView: View {
    @ObservedObject var cartManager = CartManager(quantity: 0)
    @EnvironmentObject var authentication: Authentication
    var body: some View {
        NavigationView{
        TabView{
            CartView()
                .tabItem {
                    Label("Cart", systemImage: "cart")
                    .badge(cartManager.products.count)
                    
                }
            if authentication.isValidated{
            AccountMenuView()
                .tabItem {
                    Label("Account", systemImage: "person.fill")
        }
            }
            homeView()
                .tabItem{
                    Label("Home", systemImage: "house.fill")
                }
        
    }.environmentObject(cartManager )
    .environmentObject(authentication)
            .accentColor(.hightlight)
            .onAppear(){
                DBHelper.dbHelper.createDB()
                DBHelper.dbHelper.createTables()
                DBHelper.dbHelper.dropReviewTable()
                DBHelper.dbHelper.dropProductTable()
            }
        
    }
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
