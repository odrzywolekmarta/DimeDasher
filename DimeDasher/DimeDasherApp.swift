//
//  DimeDasherApp.swift
//  DimeDasher
//
//  Created by Majka on 27/06/2023.
//

import SwiftUI

@main
struct DimeDasherApp: App {
    @StateObject private var dataController = DataController()
//    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            TabsContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
