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
    static let exit = "xmark.circle"
    static let list = "list.bullet"
    static let add = "plus.circle.fill"
    static let pieChart = "chart.pie"
    static let barChart = "chart.bar"
    static let launchImage = "launchImage"
    static let info = "info.circle"
    static let settings = "gearshape.fill"
    static let iphone = "iphone"
    static let left = "chevron.left"
    static let compactRight = "chevron.compact.right"
    static let compactLeft = "chevron.compact.left"
    static let link = "arrow.up.right.square"
    static let pencil = "pencil.line"
    static let trash = "trash"
    static let export = "square.and.arrow.up"
    static let camera = "camera.fill"
    
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
    
    //MARK: - App Storage keys
    static let showOnboarding = "showOnboarding"
    static let startingBalance = "startingBalance"
    static let currency = "currency"
    static let username = "username"

    static let imageName = "photo"
    static let folderName = "profilePicture"
    
    //MARK: - Descriptions
    static let noExpenses = "No expenses added"
    static let noIncome = "No income added"
    static let firstLaunchHeader = "Hello!"
    static let firstLaunchName = "Enter your name"
    static let firstLaunchBalance = "Enter starting balace"
    static let start = "Start"

    static let headerViewTitle = "Hello!"
    static let summaryViewTitle = "Total balance"
    static let summaryIncome = "Income"
    static let summaryExpenses = "Expenses"
    static let summaryViewThisMonth = "this month"
    
    static let transactionsTitle = "Transactions"
    static let viewAll = "View all"
    
    static let appDescription = "Dime Dasher app was created to help you track your expenses and optimize your finances."
    static let infoSectionHeader = "DIME DASHER"
    static let generalSectionHeader = "GENERAL"
    static let dev = "Developer"
    static let me = "Marta"
    static let designer = "Designer"
    static let website = "Website"
    static let github = "GitHub"
    static let githubLink = "https://github.com/odrzywolekmarta"
    static let version = "Version"
    static let versionNumber = "1.0"
    static let appSectionHeader = "APPLICATION"
    static let settingsNavigationTitle = "Settings"
    static let back = "Back"
    static let editProfile = "Edit Profile"
    static let clearData = "Clear Data"
    static let clearDataWarning = "Your data will be deleted completely. Do you want to continue?"
    static let clearDataSuccess = "Your data has been deleted succesfully."
    static let clearDataFailure = "Oops, something went wrong :("
    static let exportData = "Export Data"
    static let name = "Name"
    static let addNew = "Add new"
    static let expense = "Expense"
    static let expenseType = "Expense type"
    static let incomeType = "IncomeType"
    static let allTransactions = "All Transactions"
    static let ok = "Ok"
    static let cancel = "Cancel"
    static let sortDescription = "Sort"
    static let period = "period"
    static let amount = "amount"
    static let dateDescription = "Date:"
    //MARK: - File Extensions
    static let jpg = ".jpg"
    
    //MARK: - String Formats
    static let percent = "%.0f%%"
}



