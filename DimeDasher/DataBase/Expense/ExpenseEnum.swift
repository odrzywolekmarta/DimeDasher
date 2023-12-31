//
//  ExpenseEnum.swift
//  DimeDasher
//
//  Created by Majka on 02/07/2023.
//

import Foundation

@objc public enum ExpenseType: Int32, CaseIterable {
    case healthcare
    case travel
    case housing
    case utilities
    case groceries
    case takeout
    case clothes
    case books
    case fitness
    case car
    case gas
    case pets
    case entertainment
    case transportation
    case selfcare
    case subscriptions
    case specialOcasions
    case education
    
    public init?(rawValue: String) {
        switch rawValue {
        case "healthcare": self = .healthcare
        case "travel": self = .travel
        case "housing": self = .housing
        case "utilities": self = .utilities
        case "groceries": self = .groceries
        case "takeout": self = .takeout
        case "clothes": self = .clothes
        case "books": self = .books
        case "fitness": self = .fitness
        case "car": self = .car
        case "gas": self = .gas
        case "pets": self = .pets
        case "entertainment": self = .entertainment
        case "transportation": self = .transportation
        case "self care": self = .selfcare
        case "subscriptions": self = .subscriptions
        case "special ocasions": self = .specialOcasions
        case "education": self = .education
        default: self = .groceries
        }
    }
    
    public typealias RawValue = String
    
    public var rawValue: RawValue {
        switch self {
        case .healthcare: return "healthcare"
        case .travel: return "travel"
        case .housing: return "housing"
        case .utilities: return "utilities"
        case .groceries: return "groceries"
        case .takeout: return "takeout"
        case .clothes: return "clothes"
        case .books: return "books"
        case .fitness: return "fitness"
        case .car: return "car"
        case .gas: return "gas"
        case .pets: return "pets"
        case .entertainment: return "entertainment"
        case .transportation: return "transportation"
        case .selfcare: return "self care"
        case .subscriptions: return "subscriptions"
        case .specialOcasions: return "special ocasions"
        case .education: return "education"
        }
    }
    
    public var imageName: String {
        switch self {
        case .healthcare: return Constants.healthcare
        case .travel: return Constants.travel
        case .housing: return Constants.housing
        case .utilities: return Constants.utilities
        case .groceries: return Constants.groceries
        case .takeout: return Constants.takeout
        case .clothes: return Constants.clothes
        case .books: return Constants.books
        case .fitness: return Constants.fitness
        case .car: return Constants.car
        case .gas: return Constants.gas
        case .pets: return Constants.pets
        case .entertainment: return Constants.entertainment
        case .transportation: return Constants.transportation
        case .selfcare: return Constants.selfcare
        case .subscriptions: return Constants.subscriptions
        case .specialOcasions: return Constants.specialOcasions
        case .education: return Constants.education
        }
    }
}
