//
//  PreviewView.swift
//  NGHTLFE
//
//  Created by Michael Neibauer on 10/10/24.
//

import SwiftUI
import AVFoundation

struct PreviewView: UIViewRepresentable {
    var previewLayer: AVCaptureVideoPreviewLayer
    
    init(previewLayer: AVCaptureVideoPreviewLayer) {
        let _ = print("INIT STATUS: preview view...")
        self.previewLayer = previewLayer
    }
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: UIScreen.main.bounds)
        view.layer.addSublayer(previewLayer)
        previewLayer.frame = view.frame
        return view
    }
    
    //to conform to protocol...
    func updateUIView(_ uiView: UIView, context: Context) {}
}
