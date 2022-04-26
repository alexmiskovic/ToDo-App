//
//  ToDo_AppApp.swift
//  ToDo App
//
//  Created by Aleksa Miskovic on 26.4.22..
//

import SwiftUI

@main
struct ToDo_AppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
