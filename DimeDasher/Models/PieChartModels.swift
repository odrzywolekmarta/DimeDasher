//
//  PieChartModels.swift
//  DimeDasher
//
//  Created by Majka on 14/08/2023.
//

import Foundation
import SwiftUI

struct PieSliceData: Hashable, Identifiable {
    let id = UUID()
    var startAngle: Angle
    var endAngle: Angle
    var text: String
    var color: Color
}
