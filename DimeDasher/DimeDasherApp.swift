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

    var body: some Scene {
        WindowGroup {
            if showOnboarding {
                FirstLaunchView()
            } else {
                TabsContentView()
            }
        }
    }
}
