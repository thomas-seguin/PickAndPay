//
//  TabView.swift
//  PickAndPay
//
//  Created by admin on 7/17/22.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView{
            ContentView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            AccountMenuView()
                .tabItem {
                    Label("Account", systemImage: "person.fill")
                }
        
        }
        .accentColor(.hightlight)
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
