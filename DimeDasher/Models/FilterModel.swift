//
//  FilterModel.swift
//  DimeDasher
//
//  Created by Majka on 23/07/2023.
//

import Foundation

struct FilterModel: Identifiable {
    let id = UUID()
    let name: String
    let iconName: String
    let items: [String]
}

