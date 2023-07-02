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
    static let personCircle = "person.circle"
    static let gear = "gearshape"
    static let dismissButtonImage = "x.circle.fill"
    
    //MARK: - Expense Categories Images]
    static let income = "dollarsign.circle.fill"
    
    static let healthcare = "pill.circle.fill"
    static let tavel = "airplane.circle.fill"
    static let housing = "house.circle.fill"
    static let utilities = "lightbulb.circle.fill"
    static let groceries = "cart.circle.fill"
    static let takeout = "fork.knife.circle.fill"
    static let clothes = "tag.circle.fill"
    static let books = "book.closed.circle.fill"
    static let fitness = "tennis.racket.circle.fill"
    static let car = "car.circle.fill"
    static let gas = "fuelpump.circle.fill"
    static let pets = "pawprint.circle.fill"
    static let entertainment = "popcorn.circle.fill"
    static let transportation = "tram.circle.fill"
    static let selfcare = "heart.circle.fill"
    static let subscriptions = "film.circle.fill"
    static let specialOcasions = "gift.circle.fill"
    static let education = "graduationcap.circle.fill"
    
}
