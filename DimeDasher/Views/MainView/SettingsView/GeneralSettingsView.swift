//
//  GeneralSettingsView.swift
//  DimeDasher
//
//  Created by Majka on 29/07/2023.
//

import SwiftUI

struct GeneralSettingsView: View {
    @EnvironmentObject var viewModel: SettingsViewModel
    @State private var isDarkMode: Bool = false
    @State private var isShowingAlert: Bool = false
    
    var body: some View {
        VStack(spacing: 15) {
            //MARK: - Edit profile
            HStack {
                Text("Edit Profile")
                Spacer()
                Button {
                    // edit profile view
                } label: {
                    Image(systemName: "pencil.line")
                        .foregroundColor(Color(Constants.Colors.darkPink))
                }
                .padding(.trailing, 10)
            } // hstack
                        
            //MARK: - Clear Data
            HStack {
                Text("Clear Data")
                Spacer()
                Button {
                    isShowingAlert.toggle()
                } label: {
                    Image(systemName: "trash")
                        .foregroundColor(Color(Constants.Colors.darkPink))
                }
                .padding(.trailing, 10)
                .alert("Your data will be deleted completely. Do you want to continue?", isPresented: $isShowingAlert) {
                    Button("Ok", role: .none) {
                        viewModel.clearData()
                    }
                    Button("Cancel", role: .cancel) {
                        
                    }
                }
            }
            
            Divider()
            
            //MARK: - Dark Mode
            HStack {
                Text("Dark Mode")
                Spacer()
                Toggle("", isOn: $isDarkMode)
                    .tint(Color(Constants.Colors.darkPink))
            } // hstack
            
        
        } // vstack
        .font(.custom(Constants.Fonts.raleway, size: 16))
    }
}

struct GeneralSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        GeneralSettingsView()
            .previewLayout(.sizeThatFits)
    }
}
