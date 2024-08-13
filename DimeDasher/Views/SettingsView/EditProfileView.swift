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
    @AppStorage(Constants.username) var username: String = ""
    @AppStorage(Constants.currency) var currency: String = ""
    //    @State private var currency: String = ""
    @State private var isEditingUsername: Bool = false
    @State private var isEditingCurrency: Bool = false
    
    var body: some View {
        ZStack {
            Color(Constants.Colors.beige)
                .ignoresSafeArea()
            VStack(spacing: 20) {
                VStack {
                    Text(Constants.editProfile)
                        .font(.custom(Constants.Fonts.ralewayBold, size: 30))
                        .padding()
                    
                    ZStack {
                        if let image = viewModel.selectedPhoto {
                            Circle()
                                .fill(Color(Constants.Colors.lightPink))
                                .frame(height: 160)
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 150, height: 150)
                                .clipShape(Circle())
                            
                        } else {
                            Image(systemName: Constants.personCircle)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 100)
                                .foregroundColor(.black)
                        }
                    } // zstack
                    .overlay(alignment: .bottomTrailing) {
                        PhotosPicker(selection: $viewModel.photoSelection, matching: .images) {
                            Label {
                                Text("")
                            } icon: {
                                Image(systemName: Constants.camera)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40)
                                    .foregroundColor(Color(Constants.Colors.darkPink))
                            }
                        }
                    }
                } // vstack
                .padding()
                
                VStack {
                    HStack {
                        Text(Constants.name)
                            .font(.custom(Constants.Fonts.raleway, size: 20))
                        Spacer()
                        if isEditingUsername {
                            TextField(Constants.username, text: $username)
                                .font(.custom(Constants.Fonts.raleway, size: 20))
                                .multilineTextAlignment(.trailing)
                            Button {
                                isEditingUsername.toggle()
                            } label: {
                                Text(Constants.ok.uppercased())
                                    .font(.custom(Constants.Fonts.ralewayBold, size: 20))
                                    .foregroundColor(Color(Constants.Colors.darkPink))
                            }
                            
                        } else {
                            Text(username)
                                .font(.custom(Constants.Fonts.ralewayBold, size: 20))
                            Button {
                                isEditingUsername.toggle()
                                username = ""
                            } label: {
                                Image(systemName: Constants.pencil)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 18)
                                    .foregroundColor(Color(Constants.Colors.darkPink))
                            }
                        }
                    } // hstack
                    .padding()
                  
                    HStack {
                        Text(Constants.currency.capitalized)
                            .font(.custom(Constants.Fonts.raleway, size: 20))
                        Spacer()
                        if isEditingCurrency {
                            Picker("", selection: $currency) {
                                ForEach(Constants.currencies.keys, id: \.self) { key in
                                    Text("\(key)")
                                        .font(.custom(Constants.Fonts.ralewayBold, size: 17))
                                } // foreach
                            } // picker
                            .tint(.black)
                            
                            Button {
                                isEditingCurrency.toggle()
                            } label: {
                                Text(Constants.ok.uppercased())
                                    .foregroundColor(Color(Constants.Colors.darkPink))
                            }
                        } else {
                            Text(currency)
                                .font(.custom(Constants.Fonts.ralewayBold, size: 20))
                            Button {
                                isEditingCurrency.toggle()
                            } label: {
                                Image(systemName: Constants.pencil)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 18)
                                    .foregroundColor(Color(Constants.Colors.darkPink))
                            }
                            
                        }
                    } // hstack
                    .padding()
                    .font(.custom(Constants.Fonts.ralewayBold, size: 20))
                } // vstack
                
                Spacer()
            } // vstack
        } // zstack
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
            .environmentObject(SettingsViewModel(fileManager: LocalFileManager()))
    }
}
