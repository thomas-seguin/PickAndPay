//
//  PickAndPayApp.swift
//  PickAndPay
//
//  Created by admin on 6/27/22.
//

import SwiftUI

@main
struct PickAndPayApp: App {
    
    
    func test() {
        DBHelper.dbHelper.createTables()
    }
    
    
    @StateObject var authentication = Authentication()
    let persistenceController = PersistenceController.shared
    //hello
    var body: some Scene {
        WindowGroup {
            homeView()
            //DBHelper.dbHelper.createTables()

//            if authentication.isValidated {
//                MainTabView()
//                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
//                    .environmentObject(authentication)
//            } else {
//                LoginView()
//                    .environmentObject(authentication)
//            }
        }

    }
}

