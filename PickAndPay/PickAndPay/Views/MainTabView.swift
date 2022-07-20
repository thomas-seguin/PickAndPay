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
        DBHelper.dbHelper.createDB()
//        DBHelper.dbHelper.dropProductTable()
//        DBHelper.dbHelper.dropOrderDetailsTable()
//        DBHelper.dbHelper.dropProductOrderTable()
//        DBHelper.dbHelper.dropUserTable()
//        DBHelper.dbHelper.dropReviewTable()
//        DBHelper.dbHelper.dropCardTable()
        DBHelper.dbHelper.createTables()
        
        //InsertProductData.populate.populateCategories()
//        DBHelper.dbHelper.insertToWishList(userId: "tester@gmail.com", productId: 2)
//        DBHelper.dbHelper.productBrowsed(productId: 10, username: "tester@gmail.com")
//        DBHelper.dbHelper.insertToCart(username: "tester@gmail.com", productId: 9, qty: 1)
       DBHelper.dbHelper.placeOrder(shipAddress: "nowhere", payMode: "credit", billAddress: "somewhere", username: "tester@gmail.com")
        
        var arr = DBHelper.dbHelper.getUserOrders(username: "tester@gmail.com")
        for item in arr{
            print(item)
        }

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
