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
    @AppStorage("isDarkMode") private var isDarkMode = false

    var body: some Scene {
        WindowGroup {
            if showOnboarding {
                FirstLaunchView()
            } else {
                TabsContentView()
                    .preferredColorScheme(isDarkMode ? .dark : .light)
            }
        }
        
    }
}
