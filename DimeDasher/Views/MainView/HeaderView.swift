//
//  HeaderView.swift
//  DimeDasher
//
//  Created by Majka on 27/06/2023.
//

import SwiftUI

struct HeaderView: View {
    @EnvironmentObject var viewModel: MainViewModel
    
    var body: some View {
        HStack {
            Image(systemName: Constants.personCircle)
                .resizable()
                .scaledToFit()
                .frame(height: 50)
            VStack(alignment: .leading) {
                Text("Hello!")
                    .font(.custom(Constants.Fonts.raleway, size: 17))
                    .opacity(0.5)
                Text(viewModel.username)
                    .font(.custom(Constants.Fonts.ralewayBold, size: 20))
            }
            
            Spacer()
            
            Button {
                
            } label: {
                Image(systemName: Constants.gear)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 30)
                    .foregroundColor(Color(Constants.Colors.darkPink))
            }

        } // vstack
        .padding()
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
            .previewLayout(.sizeThatFits)
            .background(Color(Constants.Colors.beige))
            .environmentObject(MainViewModel(forPreview: true))
    }
}
