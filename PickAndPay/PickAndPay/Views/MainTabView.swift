//
//  TabView.swift
//  PickAndPay
//
//  Created by admin on 7/17/22.
//

import SwiftUI

struct MainTabView: View {
    @StateObject private var tabViewModel = TabViewModel()
    @ObservedObject var cartManager = CartManager()
    @EnvironmentObject var authentication: Authentication
    var body: some View {
        NavigationView{
        TabView{
            CartView()
                .tabItem {
                    Label("Cart", systemImage: "cart")
                    .badge(cartManager.items.count)

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
    .accentColor(.red)
   // .foregroundColor(/@START_MENU_TOKEN@/.blue/@END_MENU_TOKEN@/)


    }
        .onAppear{
            DBHelper.dbHelper.createDB()
            DBHelper.dbHelper.createTables()
            DBHelper.dbHelper.dropReviewTable()
            InsertProductData.populate.populateCategories()
            
            if tabViewModel.checkRemember(){
                authentication.isValidated = true
            }
        }
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
