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
                        Circle()
                            .fill(Color(Constants.Colors.lightPink))
                            .frame(height: 160)
                            .shadow(radius: 10)
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(1.0, contentMode: .fit)
                            .clipShape(Circle())
                            .frame(height: 150)
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
                        Label {
                            Text("")
                        } icon: {
                            Image(systemName: "camera.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40)
                                .foregroundColor(Color(Constants.Colors.darkPink))
                        }

//                            Label("", systemImage: "camera.fill")
//                                .foregroundColor(Color(Constants.Colors.darkPink))
                                
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
