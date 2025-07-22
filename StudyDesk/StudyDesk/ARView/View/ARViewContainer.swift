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

        let center = CGPoint(x: uiView.bounds.midX, y: uiView.bounds.midY)

        let results = uiView.raycast(
            from: center,
            allowing: .existingPlaneGeometry,
            alignment: .horizontal
        )

        guard let firstResult = results.first else {
            print("No horizontal plane detected.")
            return
        }

        Task {
            do {
                let entity = try await Entity(named: modelName, in: .main)
                entity.generateCollisionShapes(recursive: true)
                
                let anchor = AnchorEntity(world: firstResult.worldTransform)
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
