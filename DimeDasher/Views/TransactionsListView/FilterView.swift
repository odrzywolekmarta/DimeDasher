//
//  FilterView.swift
//  DimeDasher
//
//  Created by Majka on 17/07/2023.
//

import SwiftUI

struct FilterView: View {
    var filterType: FilterType
    
    var body: some View {
        switch filterType {
        case .sort:
            VStack {
                
            }
        case .categories:
            Text("cstegories")
        case .dates:
            Text("dates")
        }
    }
}

struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView(filterType: .sort)
    }
}
