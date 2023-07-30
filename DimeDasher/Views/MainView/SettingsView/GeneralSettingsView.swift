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
    @State private var isShowingDeleteAlert: Bool = false
    @State private var isShowingResultAlert: Bool = false
    @Binding var editProfilePresented: Bool
    
    var body: some View {
        VStack(spacing: 15) {
            //MARK: - Edit profile
            HStack {
                Text("Edit Profile")
                Spacer()
                Button {
                    editProfilePresented.toggle()
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
                    isShowingDeleteAlert.toggle()
                } label: {
                    Image(systemName: "trash")
                        .foregroundColor(Color(Constants.Colors.darkPink))
                }
                .padding(.trailing, 10)
                .alert("Your data will be deleted completely. Do you want to continue?", isPresented: $isShowingDeleteAlert) {
                    Button("Ok", role: .none) {
                        viewModel.clearData {
                            Task {
                                isShowingResultAlert.toggle()
                            }
                        }
                    }
                    Button("Cancel", role: .cancel) {
                        
                    }
                }
                .alert(viewModel.clearSuccess == .success ? "Your data has been deleted succesfully." : "Oops, something went wrong :(", isPresented: $isShowingResultAlert) {
                    Button("Ok", role: .cancel) {
                        isShowingResultAlert.toggle()
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
        GeneralSettingsView(editProfilePresented: .constant(false))
            .previewLayout(.sizeThatFits)
            .environmentObject(SettingsViewModel())
    }
}
