//
//  PostCaptureView.swift
//  NGHTLFE
//
//  Created by Michael Neibauer on 10/10/24.
//

import SwiftUI
import AVKit

final class PostCaptureView2Model: ObservableObject {
    
    let camera: CameraService2
    
    init(camera: CameraService2) {
        let _ = print("INIT STATUS: post capture view model for burst...")
        self.camera = camera
    }
    
    func getLocalVideoURL() -> URL? {   //only works for BURST
        //need some mechanism to wait... like a boolean in Camera Service ...
        return camera.videoURLs[0]
    }
}

struct PostCapture2View: View {
    
    @StateObject var vm: PostCaptureView2Model
    @State private var player = AVPlayer()
    @ObservedObject var camera: CameraService2
    
    init(camera: CameraService2) {
        let _ = print("INIT STATUS: post capture view...")
        _vm = StateObject(wrappedValue: PostCaptureView2Model(camera: camera))
        self.camera = camera
    }
    
    var body: some View {
        VStack {
            
            if camera.burstMode {
                if !camera.burstVideoDone {
                    ProgressView()
                } else {
                    //play video...
                    let videoURL = camera.videoURLs[0]
                    VideoPlayerView(videoURL: videoURL) //type string befo?
                        .frame(maxWidth: .infinity, maxHeight: .infinity) // Set the desired height for the video player
                        .padding()
                }
            } else {
                let _ = print("should be in here chief...")
                //vine video
                if !camera.vineVideoProcessed {
                    ProgressView()
                } else {
                    //play video...
                    let videoURL = camera.videoURLs[0]
                    VideoPlayerView(videoURL: videoURL) //type string befo?
                        .frame(maxWidth: .infinity, maxHeight: .infinity) // Set the desired height for the video player
                        .padding()
                }
            }
            
        }
        //.ignoresSafeArea()
    }
}

