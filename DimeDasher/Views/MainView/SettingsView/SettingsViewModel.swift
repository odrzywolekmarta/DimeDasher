//
//  SettingsViewModel.swift
//  DimeDasher
//
//  Created by Majka on 30/07/2023.
//

import Foundation
import CoreData
import _PhotosUI_SwiftUI

enum DataClearStatus {
    case success
    case failure
}

@MainActor final class SettingsViewModel: ObservableObject {
    private let persistenceController = PersistenceController.shared
    private let fileManager: LocalFileManager
    @Published var clearSuccess: DataClearStatus = .failure
    @Published private(set) var selectedPhoto: UIImage? = nil
    @Published var photoSelection: PhotosPickerItem? = nil {
        didSet {
            setImage(from: photoSelection)
        }
    }
    
    init(fileManager: LocalFileManager) {
        self.fileManager = fileManager
        selectedPhoto = fileManager.loadImage(imageName: "photo", folderName: "profilePicture")
    }
    
    func setImage(from selection: PhotosPickerItem?) {
        guard let selection else { return }
        
        Task {
            do {
                let data = try await selection.loadTransferable(type: Data.self)
                
                guard let data,
                      let uiImage = UIImage(data: data) else {
                    throw URLError(.badServerResponse)
                }
                
                selectedPhoto = uiImage
                fileManager.saveImage(image: uiImage, imageName: "photo", folderName: "profilePicture")
            } catch {
                print("Error setting image: \(error)")
            }
        }
    }

    func clearData(closure: @escaping () -> Void) {
        let expenseRequest = NSFetchRequest<Expense>(entityName: "Expense")
            do {
                let expenses = try persistenceController.viewContext.fetch(expenseRequest)
                for expense in expenses {
                    persistenceController.viewContext.delete(expense)
                }
            } catch {
                print("Error deleting expenses from data base: \(error)")
            }
        
        let incomeRequest = NSFetchRequest<Income>(entityName: "Income")
        do {
            let income = try persistenceController.viewContext.fetch(incomeRequest)
            for inc in income {
                persistenceController.viewContext.delete(inc)
            }
        } catch {
            print("Error deleting income from data base: \(error)")
        }
        
        do {
            try persistenceController.viewContext.save()
            clearSuccess = .success
        } catch {
            print("Error saving context \(error)")
            clearSuccess = .failure
        }
    }
    
}
