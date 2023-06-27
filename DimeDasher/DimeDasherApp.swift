//
//  DimeDasherApp.swift
//  DimeDasher
//
//  Created by Majka on 27/06/2023.
//

import SwiftUI

@main
struct DimeDasherApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
