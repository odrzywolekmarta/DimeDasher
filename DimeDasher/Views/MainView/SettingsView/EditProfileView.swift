//
//  EditProfileView.swift
//  DimeDasher
//
//  Created by Majka on 30/07/2023.
//

import SwiftUI
import PhotosUI

struct EditProfileView: View {
    @EnvironmentObject var viewModel: SettingsViewModel
    
    var body: some View {
        ZStack {
            Color(Constants.Colors.beige)
                .ignoresSafeArea()
            VStack {
                Text("Edit Profile")
                    .font(.custom(Constants.Fonts.ralewayBold, size: 30))
                    .padding()
                ZStack {
                    if let image = viewModel.selectedPhoto {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .clipShape(Circle())
                            .frame(height: 100)
                    } else {
                        Image(systemName: Constants.personCircle)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 100)
                            .foregroundColor(.black)
                    }
                }
                .overlay(alignment: .bottomTrailing) {
                    PhotosPicker(selection: $viewModel.photoSelection, matching: .images) {
                       
                            Label("", systemImage: "camera.fill")
                                .foregroundColor(Color(Constants.Colors.darkPink))
                    }
                }
               
                Spacer()
            } // vstack
        } // zstack
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
            .environmentObject(SettingsViewModel())
    }
}
