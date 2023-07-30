////
////  LocalFileManager.swift
////  DimeDasher
////
////  Created by Majka on 30/07/2023.
////
//
//import Foundation
//import _PhotosUI_SwiftUI
//
//final class LocalFileManager {
//    
//    init () { }
//    
//    func setImage(from selection: PhotosPickerItem?) {
//        guard let selection else { return }
//        
//        Task {
//            do {
//                let data = try await selection.loadTransferable(type: Data.self)
//                
//                guard let data,
//                      let uiImage = UIImage(data: data) else {
//                    throw URLError(.badServerResponse)
//                }
//                
//                selectedPhoto = uiImage
//                saveImage(image: uiImage)
//            } catch {
//                print("Error setting image: \(error)")
//            }
//        }
//    }
//}
