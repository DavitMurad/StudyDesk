//
//  FileManager.swift
//  StudyDesk
//
//  Created by Davit Muradyan on 19.07.25.
//

import Foundation

class FileManagerService {
    static let shared = FileManagerService()
    private let folder = "DownloadedModels"
    
    private var directoryURL: URL {
        
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let folderURL = url[0].appendingPathComponent(folder)
        if !FileManager.default.fileExists(atPath: folderURL.path) {
            try? FileManager.default.createDirectory(at: folderURL, withIntermediateDirectories: true)
        }
        return folderURL
    }

    func save(data: Data, as name: String) {
        let url = directoryURL.appendingPathComponent(name)
        try? data.write(to: url)
    }

    func load(named name: String) -> Data? {
        let url = directoryURL.appendingPathComponent(name)
        return try? Data(contentsOf: url)
    }

    func fileURL(for name: String) -> URL {
        return directoryURL.appendingPathComponent(name)
    }
}



//class LocalFileManager {
//    static let shared = LocalFileManager()
//    
//    func saveImage(image: UIImage, name: String) {
//        guard
//            let data = image.jpegData(compressionQuality: 1.0),
//            let path = getPathImage(name: name)
//        else {
//            print("Error getting data")
//            return
//        }
//        
////        let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
////        let directory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
//        
////        let directory3 = FileManager.default.temporaryDirectory
//        
////        let path = directory?.appendingPathComponent("sky.jpy")
//        
//     
//        
//        do {
//            try data.write(to: path)
//            print("Success saving")
//        } catch let error {
//            print(error.localizedDescription)
//        }
//    }
//    
//    func getImage(name: String) -> UIImage? {
//        guard
//            let path = getPathImage(name: name)?.path,
//            FileManager.default.fileExists(atPath: path) else { return nil }
//        
//        return UIImage(contentsOfFile: path)
//    }
//    
//    func getPathImage(name: String) -> URL? {
//        guard let path = FileManager
//            .default
//            .urls(for: .cachesDirectory, in: .userDomainMask)
//            .first?
//            .appendingPathComponent("sky.jpg") else { return nil }
//        
//        return path
//    }
//    
//    func deleteImage() {
//        
//    }
//}
