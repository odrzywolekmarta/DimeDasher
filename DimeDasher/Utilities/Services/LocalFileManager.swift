//
//  LocalFileManager.swift
//  DimeDasher
//
//  Created by Majka on 30/07/2023.
//

import Foundation
import _PhotosUI_SwiftUI

final class LocalFileManager {
    
    init () { }
    
    func saveImage(image: UIImage, imageName: String, folderName: String) {
        createFoderIfNeeded(folderName: folderName)
           
        guard let data = image.pngData(),
              let url = getUrlForImage(imageName: imageName, folderName: folderName) else { return }
        
        do {
            try data.write(to: url)
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
        
        return folderUrl.appending(path: imageName + ".png")
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
    
   
}
