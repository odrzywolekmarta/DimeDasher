//
//  Constants.swift
//  DimeDasher
//
//  Created by Majka on 27/06/2023.
//

import Foundation
import SwiftUI

struct Constants {
    
    //MARK: -  Custom Colors
    static let beige = "CustomBeige"
    static let lightPink = "CustomLightPink"
    static let mediumPink = "CustomMediumPink"
    static let darkPink = "CustomDarkPink"
    
    //MARK: - UI
    static var gradient: LinearGradient {
        return LinearGradient(gradient: Gradient(colors: [Color(Constants.lightPink), Color(Constants.mediumPink), Color(Constants.darkPink)]), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
    
    //MARK: - Fonts
    static let raleway = "Raleway-Regular"
    static let ralewayBold = "Raleway-Bold"
    
    //MARK: - Images
    static let arrowUpCircleFill = "arrow.up.circle.fill"
    static let arrowDownCircleFill = "arrow.down.circle.fill"

}
