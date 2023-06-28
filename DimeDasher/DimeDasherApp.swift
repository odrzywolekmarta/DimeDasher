//
//  DimeDasherApp.swift
//  DimeDasher
//
//  Created by Majka on 27/06/2023.
//

import SwiftUI

@main
struct DimeDasherApp: App {
    @AppStorage("showOnboarding") var showOnboarding: Bool = true
    @StateObject private var dataController = DataController()
//    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            if showOnboarding {
                FirstLaunchView()
                    .environment(\.managedObjectContext, dataController.container.viewContext)
            } else {
                TabsContentView()
                    .environment(\.managedObjectContext, dataController.container.viewContext)
            }
        }
    }
}
