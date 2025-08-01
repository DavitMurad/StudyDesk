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
import Combine


struct ARViewContainer: UIViewRepresentable {
    @Binding var modelName: String?
    static let timerPublisher = PassthroughSubject<Void, Never>()
    private static var timerCancellable: AnyCancellable?
    
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)

        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal]
        arView.session.run(config)
    
        let tapGesture = UITapGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.handleTap(_:)))
           arView.addGestureRecognizer(tapGesture)
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
                entity.position = .zero
                entity.orientation = simd_quatf()
                entity.transform.translation = [0, 0, 0]
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
    
    static func startTimer() {
           stopTimer()
           
           timerCancellable = Timer.publish(every: 1.0, on: .main, in: .common)
               .autoconnect()
               .sink { _ in
                   timerPublisher.send()
               }
       }
       
       static func stopTimer() {
           timerCancellable?.cancel()
           timerCancellable = nil
       }
    
    class Coordinator {
        var arView: ARView?
        
        func cleanup() {
            guard let arView = arView else { return }
            arView.session.pause()
            arView.scene.anchors.removeAll()
            self.arView = nil
        }

        func pauseARSession() {
            arView?.session.pause()
        }
        
        @objc func handleTap(_ gesture: UITapGestureRecognizer) {
                   guard let arView = arView else { return }
                   
                   let location = gesture.location(in: arView)
                   
                   if let entity = arView.entity(at: location) {
                       if entity.name == "cup_cup_0" {
                           print("Cup tapped - starting timer")
                           ARViewContainer.startTimer()
                       }
                   }
               }
        
        func trigger() {
            
        }
        
    }
    
    static func dismantleUIView(_ uiView: ARView, coordinator: Coordinator) {
        coordinator.cleanup()
    }
}
