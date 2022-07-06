//
//  PickAndPayApp.swift
//  PickAndPay
//
//  Created by admin on 6/27/22.
//

import SwiftUI

@main
struct PickAndPayApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
               // .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
