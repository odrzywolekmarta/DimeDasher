//
//  Constants.swift
//  DimeDasher
//
//  Created by Majka on 27/06/2023.
//

import Foundation
import SwiftUI
import Collections

struct Constants {
    
    static let currencies: OrderedDictionary = ["USD": "en_US", "EUR": "fr_FR", "GBP": "en_GB", "PLN": "pl"]
    
    static let chartColors = [Color(Constants.ChartColors.color1), Color(Constants.ChartColors.color2), Color(Constants.ChartColors.color3), Color(Constants.ChartColors.color4), Color(Constants.ChartColors.color5), Color(Constants.ChartColors.color6), Color(Constants.ChartColors.color7), Color(Constants.ChartColors.color8), Color(Constants.ChartColors.color9), Color(Constants.ChartColors.color10), Color(Constants.ChartColors.color11), Color(Constants.ChartColors.color12), Color(Constants.ChartColors.color13), Color(Constants.ChartColors.color14), Color(Constants.ChartColors.color15), Color(Constants.ChartColors.color16), Color(Constants.ChartColors.color17), Color(Constants.ChartColors.color18)]
    
    //MARK: -  Custom Colors
    struct Colors {
        static let beige = "CustomBeige"
        static let lightPink = "CustomLightPink"
        static let mediumPink = "CustomMediumPink"
        static let darkPink = "CustomDarkPink"
    }
    
    //MARK: - UI
    static var gradient: LinearGradient {
        return LinearGradient(gradient: Gradient(colors: [Color(Constants.Colors.lightPink), Color(Constants.Colors.mediumPink), Color(Constants.Colors.darkPink)]), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
    
    //MARK: - Fonts
    struct Fonts {
        static let raleway = "Raleway-Regular"
        static let ralewayBold = "Raleway-Bold"
    }
    
    //MARK: - Images
    static let arrowUpCircleFill = "arrow.up.circle.fill"
    static let arrowDownCircleFill = "arrow.down.circle.fill"
    static let personCircle = "person.circle"
    static let gear = "gearshape"
    static let dismissButtonImage = "x.circle.fill"
    static let filter = "slider.horizontal.3"
    static let category = "folder.fill"
    static let date = "calendar"
    static let sort = "arrow.up.arrow.down"
    //MARK: - Expense Categories Images
    
    static let income = "dollarsign.circle.fill"
    
    static let healthcare = "pill.circle.fill"
    static let travel = "airplane.circle.fill"
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
    
    //MARK: - Chart Colors
    struct ChartColors {
        static let color1 = "chartColor1"
        static let color2 = "chartColor2"
        static let color3 = "chartColor3"
        static let color4 = "chartColor4"
        static let color5 = "chartColor5"
        static let color6 = "chartColor6"
        static let color7 = "chartColor7"
        static let color8 = "chartColor8"
        static let color9 = "chartColor9"
        static let color10 = "chartColor10"
        static let color11 = "chartColor11"
        static let color12 = "chartColor12"
        static let color13 = "chartColor13"
        static let color14 = "chartColor14"
        static let color15 = "chartColor15"
        static let color16 = "chartColor16"
        static let color17 = "chartColor17"
        static let color18 = "chartColor18"
    }
}


