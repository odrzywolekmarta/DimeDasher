//
//  PieChart.swift
//  DimeDasher
//
//  Created by Majka on 14/08/2023.
//

import Foundation
import SwiftUI

struct PieChartView: View {
    @State private var activeIndex: Int = -1
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
            tempSlices.append(PieSliceData(startAngle: Angle(degrees: endDeg), endAngle: Angle(degrees: endDeg + degrees), text: String(format: "%.0f%%", value * 100 / sum), color: self.colors[i]))
            endDeg += degrees
        }
        return tempSlices
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                ZStack {
                    Color.white
                        .cornerRadius(8)
                    VStack {
                        Text(title)
                            .font(.custom(Constants.Fonts.ralewayBold, size: 20))
                        ZStack {
                            ForEach(0..<self.values.count){ i in
                                PieSliceView(pieSliceData: self.slices[i])
                                    .scaleEffect(activeIndex == i ? 1.03 : 1)
                                    .animation(Animation.spring())
                                    .padding()
                                    .frame(height: 350)

//                                    .frame(width: geometry.size.width, height: geometry.size.width)
                                    .gesture(
                                        DragGesture(minimumDistance: 0)
                                            .onChanged { value in
                                                let radius = 0.5 * widthFraction * geometry.size.width
                                                let diff = CGPoint(x: value.location.x - radius, y: radius - value.location.y)
                                                let dist = pow(pow(diff.x, 2.0) + pow(diff.y, 2.0), 0.5)
                                                if (dist > radius || dist < radius * innerRadiusFraction) {
                                                    self.activeIndex = -1
                                                    return
                                                }
                                                var radians = Double(atan2(diff.x, diff.y))
                                                if (radians < 0) {
                                                    radians = 2 * Double.pi + radians
                                                }
                                                
                                                for (i, slice) in slices.enumerated() {
                                                    if (radians < slice.endAngle.radians) {
                                                        self.activeIndex = i
                                                        break
                                                    }
                                                }
                                            }
                                            .onEnded { value in
                                                self.activeIndex = -1
                                            }
                                )
                                }
                                
                                Circle()
                                    .fill(.white)
                                    .frame(width: geometry.size.width * innerRadiusFraction, height: geometry.size.width * innerRadiusFraction)
                                
                                VStack {
                                    Text(activeIndex == -1 ? "Total" : names[activeIndex])
                                        .font(.custom(Constants.Fonts.ralewayBold, size: 27))
                                        .foregroundColor(Color(Constants.Colors.mediumPink))
                                    Text(activeIndex == -1 ? String(values.reduce(0, +)) : String(values[activeIndex]))
                                        .font(.custom(Constants.Fonts.raleway, size: 23))
                                }
                            }
                            
                    }
                    }
                   

                PieChartLegend(colors: colors,
                             names: names,
                             values: values.map { value in
                    var string = NumberFormatter().currencyFormatter.string(from: NSNumber(floatLiteral: value))
                    return string?.stringWithCurrencySymbol(currency: UserDefaults.standard.string(forKey: "currency") ?? "") ?? ""
                },
                             percents: values.map { String(format: "%.0f%%", $0 * 100 / values.reduce(0, +)) })
                
            }
            .foregroundColor(.black)
        }
    }
}

struct PieChartLegend: View {
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
                        .frame(width: 20, height: 20)
                    Text(names[i])
                        .font(.custom(Constants.Fonts.ralewayBold, size: 17))
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text(values[i])
                            .font(.custom(Constants.Fonts.ralewayBold, size: 17))

                        Text(percents[i])
                            .font(.custom(Constants.Fonts.ralewayBold, size: 14))

                            .foregroundColor(Color.gray)
                    }
                }
            }
        }
    }
}

struct PieChartView_Previews: PreviewProvider {
    static var previews: some View {
        PieChartView(values: [1300, 500, 300], colors: [Color.blue, Color.green, Color.orange], names: ["Rent", "Transport", "Education"], innerRadiusFraction: 0.55)
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
                    
                    Text(pieSliceData.text)
                        .position(
                            x: geometry.size.width * 0.5 * CGFloat(1.0 + 0.78 * cos(self.midRadians)),
                            y: geometry.size.height * 0.5 * CGFloat(1.0 - 0.78 * sin(self.midRadians))
                        )
                        .foregroundColor(Color.white)
                }
            }
            .aspectRatio(1, contentMode: .fit)
        }
    
}
