//
//  ARViewContainer.swift
//  StudyDesk
//
//  Created by Davit Muradyan on 16.07.25.
//

import Foundation
import SwiftUI
import RealityKit
import ARKit


struct ARViewContainer: UIViewRepresentable {
    @Binding var modelName: String?
    
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)

        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal]
        arView.session.run(config)
    
        context.coordinator.arView = arView
        
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        guard let modelName = modelName else { return }

        Task {
            do {
                let entity = try await Entity(named: modelName, in: .main)
                entity.generateCollisionShapes(recursive: true)
                entity.scale = SIMD3<Float>(0.2, 0.2, 0.2)         // Smaller size
                entity.orientation = simd_quatf(angle: .pi / 4, axis: [0, 1, 0]) // Y-axis rotation
                entity.position = SIMD3<Float>(0, 0, 0) 

                let anchor = AnchorEntity(plane: .horizontal)
                anchor.addChild(entity)
                uiView.scene.anchors.append(anchor)
            } catch {
                print(error)
            }
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    class Coordinator {
        var arView: ARView?
    }
}
