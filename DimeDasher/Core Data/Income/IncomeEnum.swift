//
//  IncomeEnum.swift
//  DimeDasher
//
//  Created by Majka on 03/07/2023.
//

import Foundation

@objc public enum IncomeType: Int32, CaseIterable {
    case work
    case gift
    
    public init?(rawValue: String) {
        switch rawValue {
        case "work": self = .work
        case "gift": self = .gift
//        case "crypto": self = .crypto
//        case "financial market": self = .financialMarket
        default: self = .work
        }
    }
    
    public typealias RawValue = String
    
    public var rawValue: RawValue {
        switch self {
        case .work: return "work"
        case .gift: return "gift"
//        case .crypto: return "crypto"
//        case .financialMarket: return "financial market"
        }
    }
    
}

