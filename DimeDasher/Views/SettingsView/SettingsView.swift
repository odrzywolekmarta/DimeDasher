//
//  SettingsView.swift
//  DimeDasher
//
//  Created by Majka on 29/07/2023.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel = SettingsViewModel(fileManager: LocalFileManager())
    @State private var editProfilePresented: Bool = false
    @State private var isShowingDeleteAlert: Bool = false
    @State private var isShowingResultAlert: Bool = false
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
                        Image(Constants.launchImage)
                            .cornerRadius(10)
                        Text(Constants.appDescription)
                            .opacity(0.7)
                    } // hstack
                } label: {
                    SettingsSectionHeaderView(title: Constants.infoSectionHeader, icon: Constants.info)
                    Divider()
                } // groupbox
                .padding()
                .groupBoxStyle(WhiteGroupBox())
             
                GroupBox {
                    GeneralSettingsView(isShowingDeleteAlert: $isShowingDeleteAlert, isShowingResultAlert: $isShowingResultAlert, editProfilePresented: $editProfilePresented)
                } label: {
                    SettingsSectionHeaderView(title: Constants.generalSectionHeader, icon: Constants.settings)
                    Divider()
                }
                .padding()
                .groupBoxStyle(WhiteGroupBox())

                
                GroupBox {
                    SettingsRowView(title: Constants.dev, content: Constants.me)
                    SettingsRowView(title: Constants.designer, content: Constants.me)
                    SettingsRowView(title: Constants.website, content: Constants.github, link: Constants.githubLink)
                    SettingsRowView(title: Constants.version, content: Constants.versionNumber)
                } label: {
                    SettingsSectionHeaderView(title: Constants.appSectionHeader, icon: Constants.iphone)
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
        .navigationTitle(Constants.settingsNavigationTitle)
        .sheet(isPresented: $editProfilePresented, content: {
            EditProfileView()
                .environmentObject(viewModel)
                .presentationDetents([.medium])
        })
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    refresh()
                    dismiss()
                } label: {
                    HStack {
                        Image(systemName: Constants.left)
                            .foregroundColor(Color(Constants.Colors.darkPink))
                        Text(Constants.back)
                            .font(.custom(Constants.Fonts.ralewayBold, size: 18))
                        .foregroundColor(Color(Constants.Colors.darkPink))
                    }
                }
            } // toolbar item
        } // toolbar
        .toolbarBackground(.hidden, for: .navigationBar)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(refresh: { })
    }
}
