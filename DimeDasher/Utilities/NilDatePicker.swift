//
//  NilDatePicker.swift
//  DimeDasher
//
//  Created by Majka on 29/07/2023.
//

import Foundation
import SwiftUI

//struct NilDatePicker: View {
//    let label:String
//    @Binding var date: Date?
//    @State private var hidenDate: Date = Date()
//
//    init(_ label: String, selection: Binding<Date?>) {
//        self.label = label
//        self._date = selection
//    }
//
//    var body: some View {
//        GeometryReader { proxy in
//            ZStack {
//                DatePicker(label, selection: $hidenDate, displayedComponents: .date)
//                if date == nil {
//                    Text(label)
//                        .font(.custom(Constants.Fonts.ralewayBold, size: 17))
////                        .italic()
//                        .foregroundColor(.gray)
//                        .frame(width: proxy.size.width - CGFloat(label.count * 8), height: proxy.size.height, alignment: .trailing)
//                        .background(Color(Constants.Colors.lightPink))
//                        .frame(maxWidth: .infinity, alignment: .trailing)
//                        .allowsHitTesting(false)
//                }
//            }
//            .onChange(of: hidenDate, perform: { _ in
//                self.date = hidenDate
//            })
//        }
//    }
//}

struct NilDatePicker: View {
    
    let label: String
    let prompt: String
    
    @Binding var date: Date?
    @State private var hidenDate: Date = Date()
    @State private var showDate: Bool = false
    
    init(_ label: String, prompt: String, selection: Binding<Date?>) {
        self.label = label
        self.prompt = prompt
        self._date = selection
    }
    
    var body: some View {
        ZStack {
            HStack {
                Text(label)
                    .multilineTextAlignment(.leading)
                    .font(.custom(Constants.Fonts.ralewayBold, size: 17))
                Spacer()
                if showDate {
                    Button {
                        showDate = false
                        date = nil
                    } label: {
                        Image(systemName: "xmark.circle")
                            .resizable()
                            .frame(width: 16, height: 16)
                    }
                    DatePicker(
                        label,
                        selection: $hidenDate,
                        displayedComponents: .date
                    )
                    .labelsHidden()
                    .onChange(of: hidenDate) { newDate in
                        date = newDate
                    }
                    
                } else {
                    Button {
                        showDate = true
                        date = hidenDate
                    } label: {
                        Text(prompt)
                            .font(.custom(Constants.Fonts.ralewayBold, size: 17))
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color(Constants.Colors.darkPink))
                    }
                    .buttonStyle(.bordered)
                    .multilineTextAlignment(.trailing)
                }
            }
        }
    }
}
