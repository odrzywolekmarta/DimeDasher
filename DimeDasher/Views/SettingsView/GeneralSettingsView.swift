//
//  GeneralSettingsView.swift
//  DimeDasher
//
//  Created by Majka on 29/07/2023.
//

import SwiftUI

struct GeneralSettingsView: View {
    @EnvironmentObject var viewModel: SettingsViewModel
    @Binding var isShowingDeleteAlert: Bool
    @Binding var isShowingResultAlert: Bool
    @Binding var editProfilePresented: Bool
    
    var body: some View {
        VStack(spacing: 15) {
            //MARK: - Edit profile
            HStack {
                Text(Constants.editProfile)
                Spacer()
                Button {
                    editProfilePresented.toggle()
                } label: {
                    Image(systemName: Constants.pencil)
                        .foregroundColor(Color(Constants.Colors.darkPink))
                }
                .padding(.trailing, 10)
            } // hstack
                        
            //MARK: - Clear Data
            HStack {
                Text(Constants.clearData)
                Spacer()
                Button {
                    isShowingDeleteAlert.toggle()
                } label: {
                    Image(systemName: Constants.trash)
                        .foregroundColor(Color(Constants.Colors.darkPink))
                }
                .padding(.trailing, 10)
                .alert(Constants.clearDataWarning, isPresented: $isShowingDeleteAlert) {
                    Button(Constants.ok, role: .none) {
                        viewModel.clearData { }
                            isShowingResultAlert.toggle()
                        
                    }
                    Button(Constants.cancel, role: .cancel) {
                        
                    }
                }
                .alert(viewModel.clearSuccess == .success ? Constants.clearDataSuccess : Constants.clearDataFailure, isPresented: $isShowingResultAlert) {
                    Button(Constants.ok, role: .cancel) {
                        isShowingResultAlert.toggle()
                    }
                }
            }
        //MARK: - Esport Data
            HStack {
                Text(Constants.exportData)
                Spacer()
                ShareLink(item: viewModel.getFileURL()) {
                    Image(systemName: Constants.export)
                        .foregroundColor(Color(Constants.Colors.darkPink))
                }
              
                .padding(.trailing, 10)
            }
        } // vstack
        .font(.custom(Constants.Fonts.raleway, size: 16))
    }
}

struct GeneralSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        GeneralSettingsView(isShowingDeleteAlert: .constant(false), isShowingResultAlert: .constant(false), editProfilePresented: .constant(false))
            .previewLayout(.sizeThatFits)
            .environmentObject(SettingsViewModel(fileManager: LocalFileManager()))
    }
}
