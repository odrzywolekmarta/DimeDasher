//
//  SettingsView.swift
//  DimeDasher
//
//  Created by Majka on 29/07/2023.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel = SettingsViewModel()
    @State private var darkMode: Bool = false
    var refresh: (() -> Void)

    init(refresh: @escaping (() -> Void)) {
        UINavigationBar.appearance().titleTextAttributes = [.font : UIFont(name: Constants.Fonts.ralewayBold, size: 20) ?? .systemFont(ofSize: 20)]
        self.refresh = refresh
    }
    
    var body: some View {
        ScrollView {
            VStack {
                GroupBox {
                    HStack {
                        Image("launchImage")
                            .cornerRadius(10)
                        Text("Dime Dasher app was created to help you track your expenses and optimize your finances.")
                            .opacity(0.7)
                    } // hstack
                } label: {
                    SettingsSectionHeaderView(title: "DIME DASHER", icon: "info.circle")
                    Divider()
                } // groupbox
                .padding()
                .groupBoxStyle(WhiteGroupBox())
             
                GroupBox {
                    GeneralSettingsView()
                } label: {
                    SettingsSectionHeaderView(title: "GENERAL", icon: "gearshape.fill")
                    Divider()
                }
                .padding()
                .groupBoxStyle(WhiteGroupBox())

                
                GroupBox {
                    SettingsRowView(title: "Developer", content: "Marta")
                    SettingsRowView(title: "Designer", content: "Marta")
                    SettingsRowView(title: "Website", content: "GitHub", link: "https://github.com/odrzywolekmarta")
                    SettingsRowView(title: "Version", content: "1.0")
                } label: {
                    SettingsSectionHeaderView(title: "APPLICATION", icon: "iphone")
                    Divider()
                }
                .padding()
                .groupBoxStyle(WhiteGroupBox())

            }
        }
        .background(Color(Constants.Colors.beige))
        .font(.custom(Constants.Fonts.raleway, size: 17))
        .environmentObject(viewModel)
        .navigationBarBackButtonHidden(true)
        .navigationTitle("Settings")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    refresh()
                    dismiss()
                } label: {
                    HStack {
                        Image(systemName: "chevron.left")
                            .foregroundColor(Color(Constants.Colors.darkPink))
                        Text("Back")
                            .font(.custom(Constants.Fonts.ralewayBold, size: 18))
                        .foregroundColor(Color(Constants.Colors.darkPink))
                    }
                }
            } // toolbar item
        } // toolbar
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(refresh: { })
    }
}
