//
//  DataController.swift
//  DimeDasher
//
//  Created by Majka on 27/06/2023.
//

import Foundation
import CoreData

final class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "DimeDasher")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
