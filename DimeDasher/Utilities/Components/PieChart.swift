//
//  PieChart.swift
//  DimeDasher
//
//  Created by Majka on 14/08/2023.
//

import Foundation
import SwiftUI

struct PieChartView: View {
    @Binding var activeIndex: Int
    @State var title: String = ""
    @State var footer: String = ""
    public let values: [Double]
    public var colors: [Color]
    public let names: [String]
    let widthFraction: CGFloat = 0.75
    public var innerRadiusFraction: CGFloat
    
    var slices: [PieSliceData] {
        let sum = values.reduce(0, +)
        var endDeg: Double = 0
        var tempSlices: [PieSliceData] = []
        
        for (i, value) in values.enumerated() {
            let degrees: Double = value * 360 / sum
            tempSlices.append(PieSliceData(startAngle: Angle(degrees: endDeg), endAngle: Angle(degrees: endDeg + degrees), text: String(format: "%.0f%%", value * 100 / sum), color: colors[i]))
            endDeg += degrees
        }
        return tempSlices
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(0..<values.count, id: \.self) { i in
                    PieSliceView(pieSliceData: slices[i])
                        .scaleEffect(activeIndex == i ? 1.05 : 1)
                        .animation(Animation.spring())
                        .position(x: geometry.size.width * 0.5, y: geometry.size.height * 0.5)
                        .onTapGesture {
                            if activeIndex == i {
                                activeIndex = -1
                            } else {
                                activeIndex = i
                            }
                        }
                } // foreach
                
                Circle()
                    .fill(.white)
                    .frame(width: geometry.size.width * innerRadiusFraction, height: geometry.size.width * innerRadiusFraction)
                    .onTapGesture {
                        activeIndex = -1
                    }
                
                VStack {
                    Text(activeIndex == -1 ? "Total" : names[activeIndex])
                        .font(.custom(Constants.Fonts.ralewayBold, size: 27))
                        .foregroundColor(.black)
                    Text(activeIndex == -1 ? values.reduce(0, +).moneyValue() : values[activeIndex].moneyValue())
                        .font(.custom(Constants.Fonts.raleway, size: 23))
                }
            }
        }
    }
}

struct PieChartLegend: View {
    @Binding var activeIndex: Int
    var colors: [Color]
    var names: [String]
    var values: [String]
    var percents: [String]
    
    var body: some View {
        ScrollView {
            ForEach(0..<values.count) { i in
                HStack {
                    RoundedRectangle(cornerRadius: 5.0)
                        .fill(colors[i])
                        .frame(width: 25, height: 25)
                    Text(names[i])
                        .font(.custom(activeIndex == i ? Constants.Fonts.ralewayBold : Constants.Fonts.raleway, size: activeIndex == i ? 20 : 18))
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text(values[i])
                            .font(.custom(activeIndex == i ? Constants.Fonts.ralewayBold : Constants.Fonts.raleway, size: activeIndex == i ? 20 : 18))
                        
                        Text(percents[i])
                            .font(.custom(Constants.Fonts.ralewayBold, size: activeIndex == i ? 17 : 15))
                            .foregroundColor(activeIndex == i ? Color(Constants.Colors.darkPink) : Color.gray)
                    } // vstack
                } // hstack
                .onTapGesture {
                    if activeIndex == i {
                        activeIndex = -1
                    } else {
                        activeIndex = i
                    }
                }
            } // foreach
        } // scrollview
        .scrollIndicators(.hidden)
    }
}

struct PieChartView_Previews: PreviewProvider {
    static var previews: some View {
        PieChartView(activeIndex: .constant(-1), values: [10, 100, 500, 300], colors: [Color.blue, Color.green, Color.orange, Color.red], names: ["Rent", "Transport", "Education", "jajko"], innerRadiusFraction: 0.55)
    }
    
}


struct PieSliceView: View {
    var pieSliceData: PieSliceData
    
    var midRadians: Double {
        return Double.pi / 2.0 - (pieSliceData.startAngle + pieSliceData.endAngle).radians / 2.0
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Path { path in
                    let width: CGFloat = min(geometry.size.width, geometry.size.height)
                    let height = width
                    
                    let center = CGPoint(x: width * 0.5, y: height * 0.5)
                    
                    path.move(to: center)
                    
                    path.addArc(
                        center: center,
                        radius: width * 0.5,
                        startAngle: Angle(degrees: -90.0) + pieSliceData.startAngle,
                        endAngle: Angle(degrees: -90.0) + pieSliceData.endAngle,
                        clockwise: false)
                    
                }
                .fill(pieSliceData.color)
//                .zIndex(0)

//                Text(pieSliceData.text)
//                    .zIndex(1)
//                    .position(
//                        x: geometry.size.width * 0.5 * CGFloat(1.0 + 0.78 * cos(midRadians)),
//                        y: geometry.size.height * 0.5 * CGFloat(1.0 - 0.78 * sin(midRadians))
//                    )
//                    .foregroundColor(Color.white)
            }
        }
        .aspectRatio(1, contentMode: .fit)
    }
    
}
