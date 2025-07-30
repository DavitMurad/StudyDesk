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
