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
    init() {
        UITabBar.appearance().backgroundColor = UIColor.white

    }
    var body: some View {
        
        
            
        NavigationView{
            ZStack{
                Color.red.edgesIgnoringSafeArea(.all)
       
            TabView{
            
                    homeView()
                
                        .tabItem{
                            Label("Home", systemImage: "house.fill")
                        }
                        
                
           
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
            

    }.environmentObject(cartManager )
    .environmentObject(authentication)
    .accentColor(.hightlight)
    


    }
        .onAppear{
            DBHelper.dbHelper.createDB()
            DBHelper.dbHelper.createTables()
           // DBHelper.dbHelper.dropProductTable()
            InsertProductData.populate.populateCategories()
            
            if tabViewModel.checkRemember(){
                authentication.isValidated = true
            }
        }
    }
}
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
