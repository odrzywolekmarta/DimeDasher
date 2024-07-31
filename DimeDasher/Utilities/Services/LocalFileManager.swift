//
//  LocalFileManager.swift
//  DimeDasher
//
//  Created by Majka on 30/07/2023.
//

import Foundation
import _PhotosUI_SwiftUI

final class LocalFileManager {
    
    init() {}
    
    //MARK: - Image Methods
    func saveImage(image: UIImage, imageName: String, folderName: String) {
        createFoderIfNeeded(folderName: folderName)
        
        guard let url = getUrlForImage(imageName: imageName, folderName: folderName) else { return }
        
        do {
            try image.jpegData(compressionQuality: 1.0)?.write(to: url, options: .atomic)
        } catch let error {
            print("Error saving image \(error)")
        }
    }
    
    func loadImage(imageName: String, folderName: String) -> UIImage? {
        guard let url = getUrlForImage(imageName: imageName, folderName: folderName),
              FileManager.default.fileExists(atPath: url.path) else {
            return nil
        }
        return UIImage(contentsOfFile: url.path())
    }
    
    func getUrlForFolder(folderName: String) -> URL? {
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return nil
        }
        
        return url.appending(path: folderName)
    }
    
    func getUrlForImage(imageName: String, folderName: String) -> URL? {
        guard let folderUrl = getUrlForFolder(folderName: folderName) else {
            return nil
        }
        
        return folderUrl.appending(path: imageName + ".jpg")
    }
    
    func createFoderIfNeeded(folderName: String) {
        guard let url = getUrlForFolder(folderName: folderName) else { return }
        
        if !FileManager.default.fileExists(atPath: url.path()) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
            } catch {
                print("Error creating directory. Folder name \(folderName), \(error)")
            }
        }
    }
    
    //MARK: - Expenses Data to CSV
    func createCSV(from array: [ExpenseModel]) -> URL {
        let heading = "Date, Amount, Category, Description\n"
        let rows: [String] = array.map { "\($0.expenseDate.toString()),\($0.amount.moneyValue()),\($0.expenseType.rawValue),\($0.expenseDescription)"}
        let stringData = heading + rows.joined(separator: "\n")
        var fileURL: URL! // TODO: FIX FORCE UNWRAP SITUATIONA
        do {
            let path = try FileManager.default.url(for: .documentDirectory,
                                                   in: .allDomainsMask,
                                                   appropriateFor: nil,
                                                   create: false)
            
            let fileURL = path.appendingPathComponent("Expenses-Data.csv")
            try stringData.write(to: fileURL, atomically: true, encoding: .utf8)
            print("File url: \(fileURL)")
        } catch {
            print("Error generating csv file: \(error.localizedDescription)")
        }
        
        return fileURL
    }
}
