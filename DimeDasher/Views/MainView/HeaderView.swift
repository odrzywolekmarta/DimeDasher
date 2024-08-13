//
//  HeaderView.swift
//  DimeDasher
//
//  Created by Majka on 27/06/2023.
//

import SwiftUI

struct HeaderView: View {
    @EnvironmentObject var viewModel: MainViewModel
    @EnvironmentObject var listViewModel: TransactionsListViewModel
    @AppStorage(Constants.username) var username: String = ""

    var body: some View {
            HStack {
                if let pic = viewModel.profilePic {
                    ZStack {
                        Circle()
                            .fill(Color(Constants.Colors.lightPink))
                            .frame(height: 70)
                        Image(uiImage: pic)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 65, height: 65)
                            .clipShape(Circle())
                    }
                } else {
                    Image(systemName: Constants.personCircle)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 70)
                }
               
                VStack(alignment: .leading) {
                    Text(Constants.headerViewTitle)
                        .font(.custom(Constants.Fonts.raleway, size: 17))
                        .opacity(0.5)
                    Text(username)
                        .font(.custom(Constants.Fonts.ralewayBold, size: 20))
                }
                
                Spacer()
                
                NavigationLink {
                    SettingsView {
                        viewModel.fetchIncome()
                        viewModel.fetchExpenses()
                        listViewModel.fetchIncome()
                        listViewModel.fetchExpenses()
                        viewModel.getProfilePicture()
                    }
                } label: {
                    Image(systemName: Constants.gear)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 30)
                        .foregroundColor(Color(Constants.Colors.darkPink))
                } // navigation link
            } // vstack
            .padding()
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
            .previewLayout(.sizeThatFits)
            .background(Color(Constants.Colors.beige))
            .environmentObject(MainViewModel(fileManager: LocalFileManager()))
    }
}
