//
//  SummaryView.swift
//  DimeDasher
//
//  Created by Majka on 27/06/2023.
//

import SwiftUI

struct SummaryView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 30)
            .fill(Constants.gradient)
            .frame(height: 200)
            .shadow(radius: 20)
            .padding()
            .overlay {
                VStack(alignment: .center, spacing: 30) {
                    VStack {
                        Text("Total balance")
                            .font(.custom(Constants.ralewayBold, size: 20))
                        Text("$10,000")
                            .font(.custom(Constants.ralewayBold, size: 60))
                    } // vstack
                   
                    HStack(spacing: 70) {
                        VStack {
                            Text("Income")
                                .font(.custom(Constants.raleway, size: 18))
                            HStack {
                                Image(systemName: Constants.arrowUpCircleFill)
                                    .opacity(0.6)
                                Text("$3000")
                                    .font(.custom(Constants.ralewayBold, size: 18))
                            } // hstacl
                        }// vstack
                        
                        VStack {
                            Text("Expenses")
                                .font(.custom(Constants.raleway, size: 18))
                            HStack {
                                Image(systemName: Constants.arrowDownCircleFill)
                                    .opacity(0.6)
                                Text("$1790")
                                    .font(.custom(Constants.ralewayBold, size: 18))
                            } // hstack
                        }// vstack
                        
                    } // hstack
                    
                } // vstack
                .foregroundColor(.white)
            }
    }
}

struct SummaryView_Previews: PreviewProvider {
    static var previews: some View {
        SummaryView()
            .previewLayout(.sizeThatFits)
    }
}