//
//  SummaryView.swift
//  DimeDasher
//
//  Created by Majka on 27/06/2023.
//

import SwiftUI

struct SummaryView: View {
    @EnvironmentObject var viewModel: MainViewModel
    
    var body: some View {
        RoundedRectangle(cornerRadius: 30)
            .fill(Constants.gradient)
            .frame(height: 200)
            .shadow(radius: 20)
            .padding()
            .overlay {
                VStack(alignment: .center) {
                    VStack {
                        Text(Constants.summaryViewTitle)
                            .font(.custom(Constants.Fonts.ralewayBold, size: 18))
                        Text(viewModel.balance)
                            .font(.custom(Constants.Fonts.ralewayBold, size: 55))
                    } // vstack
                   
                    HStack(spacing: 70) {
                        VStack {
                            Text(Constants.summaryIncome)
                                .font(.custom(Constants.Fonts.ralewayBold, size: 18))
                            Text(Constants.summaryViewThisMonth)
                                .font(.custom(Constants.Fonts.raleway, size: 14))
                            HStack {
                                Image(systemName: Constants.arrowUpCircleFill)
                                    .opacity(0.6)
                                Text(viewModel.incomeThisMonth)
                                    .font(.custom(Constants.Fonts.ralewayBold, size: 18))
                            } // hstacl
                        }// vstack
                        
                        VStack {
                            Text(Constants.summaryExpenses)
                                .font(.custom(Constants.Fonts.ralewayBold, size: 18))
                            Text(Constants.summaryViewThisMonth)
                                .font(.custom(Constants.Fonts.raleway, size: 14))
                            HStack {
                                Image(systemName: Constants.arrowDownCircleFill)
                                    .opacity(0.6)
                                Text(viewModel.expensesThisMonth)
                                    .font(.custom(Constants.Fonts.ralewayBold, size: 18))
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
            .environmentObject(MainViewModel(fileManager: LocalFileManager()))
    }
}
