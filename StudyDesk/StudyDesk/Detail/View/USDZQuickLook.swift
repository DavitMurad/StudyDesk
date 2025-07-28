//
//  USDZQuickLook.swift
//  StudyDesk
//
//  Created by Davit Muradyan on 27.07.25.
//

import Foundation
import QuickLook
import QuickLookThumbnailing
import SwiftUI

struct USDZQuickLook: UIViewControllerRepresentable {
    let modelName: String

    func makeUIViewController(context: Context) -> QLPreviewController {
        let controller = QLPreviewController()
        controller.dataSource = context.coordinator
        return controller
    }

    func updateUIViewController(_ controller: QLPreviewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(modelName: modelName)
    }

    class Coordinator: NSObject, QLPreviewControllerDataSource {
        let modelName: String

        init(modelName: String) {
            self.modelName = modelName
        }

        func numberOfPreviewItems(in controller: QLPreviewController) -> Int { 1 }

        func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
            let fileWithExt = modelName.hasSuffix(".usdz") ? modelName : "\(modelName).usdz"
            
            if let url = Bundle.main.url(forResource: fileWithExt, withExtension: nil) {
                return url as QLPreviewItem
            
            } else {
                fatalError("Could not load preview item")
            }
        }
    }
}

