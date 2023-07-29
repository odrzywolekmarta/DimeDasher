//
//  SideMenuView.swift
//  DimeDasher
//
//  Created by Majka on 17/07/2023.
//

import SwiftUI

struct SideMenuView: View {
    @EnvironmentObject var viewModel: TransactionsListViewModel
    @State private var selectedSorting: SortType = .newest
    @State private var selectedCategories = [String]()
    @State private var selectedFromDate: Date?
    @State private var selectedToDate: Date?
    @State private var dateSelectionStyle: DateSelection = .range
    @State private var selectedDates: Set<DateComponents> = []
    @State private var isSelectingFromDate: Bool = false
    @State private var isSelectingToDate: Bool = false
    @Binding var sideBarVisible: Bool
    @Binding var filtersVisible: Bool
    var sideBarWidth = UIScreen.main.bounds.size.width * 0.8
    
    func setDatesOnPickers() {
        if selectedFromDate != nil &&
           selectedToDate != nil {
            selectedToDate = selectedFromDate
        }
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            HStack {
                List {
                    //MARK: - Sorting
                    DisclosureGroup {
                        ForEach(SortType.allCases, id: \.self) { type in
                            Text(type.rawValue)
                                .font(.custom(selectedSorting == type ? Constants.Fonts.ralewayBold : Constants.Fonts.raleway, size: 17))
                                .onTapGesture {
                                    selectedSorting = type
                                }
                        }
                    } label: {
                        HStack {
                            Image(systemName: Constants.sort)
                            Text("Sort")
                                .font(.custom(Constants.Fonts.ralewayBold, size: 20))
                        }
                    }
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                    
                    //MARK: - Categories
                    DisclosureGroup {
                        Text("Income")
                            .font(.custom(Constants.Fonts.ralewayBold, size: 18))
                        ForEach(IncomeType.allCases, id: \.self) { income in
                            Text(income.rawValue)
                                .font(.custom(selectedCategories.contains(income.rawValue) ? Constants.Fonts.ralewayBold : Constants.Fonts.raleway, size: 17))
                                .onTapGesture {
                                    if selectedCategories.contains(income.rawValue) {
                                        selectedCategories.removeAll(where: { $0 == income.rawValue})
                                    } else {
                                        selectedCategories.append(income.rawValue)
                                    }
                                }
                        }
                        Text("Expenses")
                            .font(.custom(Constants.Fonts.ralewayBold, size: 18))
                        ForEach(ExpenseType.allCases, id: \.self) { expense in
                            Text(expense.rawValue)
                                .font(.custom(selectedCategories.contains(expense.rawValue) ? Constants.Fonts.ralewayBold : Constants.Fonts.raleway, size: 17))
                                .onTapGesture {
                                    if selectedCategories.contains(expense.rawValue) {
                                        selectedCategories.removeAll(where: { $0 == expense.rawValue})
                                    } else {
                                        selectedCategories.append(expense.rawValue)
                                    }
                                }
                        }
                    } label: {
                        HStack {
                            Image(systemName: Constants.category)
                            Text("Category")
                                .font(.custom(Constants.Fonts.ralewayBold, size: 20))
                        } // hstack
                    }
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                    
                    //MARK: - Dates
                    DisclosureGroup {
                        Picker("", selection: $dateSelectionStyle) {
                            ForEach(DateSelection.allCases, id: \.self) { type in
                                Text(type.rawValue)
                            } // foreach
                        } // picker
                        .pickerStyle(.segmented)
                        switch dateSelectionStyle {
                        case .range:
                            NilDatePicker("From:", prompt: "select", selection: $selectedFromDate)
                            
                            NilDatePicker("To:", prompt: "select", selection: $selectedToDate)
                            
                        case .multipleDates:
                            MultiDatePicker("", selection: $selectedDates)
                            HStack {
                                Spacer()
                                Button {
                                    selectedDates.removeAll()
                                } label: {
                                    Text("Clear filters")
                                        .font(.custom(Constants.Fonts.ralewayBold, size: 17))
                                        .foregroundColor(Color(Constants.Colors.darkPink))
                                } // button
                                .buttonStyle(.bordered)
                            }
                        }
                    } label: {
                        HStack {
                            Image(systemName: Constants.date)
                            Text("Date")
                                .font(.custom(Constants.Fonts.ralewayBold, size: 20))
                        } // hstack
                    }
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                    
                    //MARK: - Buttons
                    HStack {
                        Spacer()
                        VStack {
                            Button {
                                switch dateSelectionStyle {
                                case .range:
                                    viewModel.applyFilers(fromDate: selectedFromDate,
                                                          toDate: selectedToDate,
                                                          categories: selectedCategories,
                                                          sort: selectedSorting)
                                case .multipleDates:
                                    viewModel.applyFilers(dates: selectedDates, categories: selectedCategories, sort: selectedSorting)
                                }
                                sideBarVisible.toggle()
                            } label: {
                                Text("Apply filters")
                                    .font(.custom(Constants.Fonts.ralewayBold, size: 20))
                            }
                            .buttonStyle(.bordered)
                            Button {
//                                selectedToDate = nil
//                                selectedFromDate = nil
                                selectedCategories = []
                                selectedDates = []
                                selectedSorting = .newest
                            } label: {
                                Text("Clear")
                                    .font(.custom(Constants.Fonts.ralewayBold, size: 20))
                            }
                            .buttonStyle(.bordered)
                        }
                        Spacer()
                    } // hstack
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                } // list
                .tint(Color(Constants.Colors.darkPink))
                .background(Color(Constants.Colors.lightPink))
                
                .listStyle(.plain)
                .frame(width: sideBarWidth)
                .offset(x: sideBarVisible ? 0 : -sideBarWidth)
                
                Spacer()
            } // hstack
        } // zstack
    }
}

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView(sideBarVisible: .constant(true), filtersVisible: .constant(true))
            .environmentObject(TransactionsListViewModel())
    }
}
