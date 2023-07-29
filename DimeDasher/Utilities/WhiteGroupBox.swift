//
//  WhiteGroupBox.swift
//  DimeDasher
//
//  Created by Majka on 29/07/2023.
//

import Foundation
import SwiftUI

struct WhiteGroupBox: GroupBoxStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack {
            configuration.label
            configuration.content
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.white)
        )
    }
}
