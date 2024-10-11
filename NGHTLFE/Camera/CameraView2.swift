//
//  CameraView2.swift
//  CameraAndVideo
//
//  Created by Michael Neibauer on 10/1/24.
//

import SwiftUI
import AVKit
import Combine

struct CameraView2: View {
    //for camera
    @StateObject private var camera = CameraService2()
    @State private var previewLayer: AVCaptureVideoPreviewLayer?
    let burstDuration = 3.0
    let vineLimit = 5.0
    
    //for burst button animation
    @State var percentRecorded: CGFloat = 0.0
    @State private var burstButtonTimer: Timer?
    @State private var vineButtonTimer: Timer?
    
    //for next view
    @State private var viewVideo = false
    
    init() {
        let _ = print("INIT STATUS: camera view...")
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                //live camera
                if let layer = previewLayer {
                    PreviewView(previewLayer: layer)
                        .ignoresSafeArea()
                }
                
                VStack {
                    Spacer()
                    
                    //button -> switch camera settings
                    Button {
                        //reset because both modes share variable...
                        //use case - switch while recording ...
                        //may need more items then that...
                        //yeah, just gray out in that scenario...
                        
                        percentRecorded = 0.0
                        
                        if !camera.burstMode {
                            camera.configureBurstSettings()
                        } else {
                            camera.configureVineSettings()
                        }
                        
                    } label: {
                        Image(systemName: camera.burstMode ? "camera.circle.fill" : "video.circle.fill")
                            .resizable()
                            .foregroundStyle(.white)
                            .frame(width: 40, height: 40)
                    }
                    .offset(x: 100)
                    
                    if camera.burstMode {
                        //burst button
                        Button {
                            //MARK: CAMERA BURST START
                            camera.startBurstRecording()
                            //play the button animation
                            playBurstAnimation(duration: burstDuration)
                        } label: {
                            VideoButton(percentRecorded: $percentRecorded)
                        }
                    } else {
                        //vine button
                        Button {
                            //MARK: VINE BURST START/PAUSE
                            if camera.isRecording {
                                camera.stopVineRecording()
                                pauseVineAnimation()
                            } else {
                                camera.startVineRecording()
                                playVineAnimation(limit: vineLimit)
                            }
                        } label: {
                            VideoButton(percentRecorded: $percentRecorded)
                        }
                    }
                    
                }
                
            }
            .onAppear {
                print("ON APPEAR: camera view...")
                previewLayer = camera.getPreviewLayer()
            }
            //loading too soon...
            .navigationDestination(isPresented: $viewVideo) {
                LazyView { PostCapture2View(camera: camera) }
            }
        }
    }
    
    func playBurstAnimation(duration: TimeInterval) {
        let totalDuration = duration
        
        burstButtonTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            if percentRecorded < 1.0 {
                percentRecorded += 0.15 / totalDuration     //so it's not exactly 5 seconds... we can speed up or slow down HERE
            } else {
                //button animation finished
                //MARK: CAMERA BURST STOP
                camera.stopBurstRecording()
                //...some time delay...
                //camera.processVine()
                burstButtonTimer?.invalidate()
                percentRecorded = 0.0
                viewVideo = true //only way right now ... also if you click a side button!
            }
        }
    }
    
    func playVineAnimation(limit: CGFloat) {
        let totalDuration = limit
        
        vineButtonTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            if percentRecorded < 1.0 {
                percentRecorded += 0.15 / totalDuration     //so it's not exactly 5 seconds... we can speed up or slow down HERE
            } else {
                //button animation finished
                //MARK: CAMERA VINE STOP
                camera.stopVineRecording()
                camera.vineVideoDone = true
                //...some time delay...
                //camera.processVine()
                vineButtonTimer?.invalidate()
                percentRecorded = 0.0
                viewVideo = true //only way right now ... also if you click a side button!
            }
        }
    }
    
    func pauseVineAnimation() {
        // only messing with the ticking timer did NOT reset the percent recorded
        vineButtonTimer?.invalidate()
    }
}
