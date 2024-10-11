//
//  CameraManager.swift
//  NGHTLFE
//
//  Created by Michael Neibauer on 10/10/24.
//
import AVFoundation


enum VideoType {
    case burst
    case vine
}

final class CameraService2: NSObject, ObservableObject, AVCaptureFileOutputRecordingDelegate {
    
    @Published var burstMode = true
    @Published var isRecording = false
    @Published var burstVideoDone: Bool = false
    var vineVideoDone: Bool = false
    @Published var vineVideoProcessed: Bool = false
    
    // AVCaptureSession is responsible for managing the flow of data from input devices to outputs
    private let captureSession = AVCaptureSession()
    
    // AVCaptureMovieFileOutput is used to capture video data to a file
    private var videoOutput = AVCaptureMovieFileOutput()
    
    // The current video capture device (camera)
    private var captureDevice: AVCaptureDevice?
    
    private let flashlight = TorchManager()
    
    private(set) var videoURLs: [URL] = []
    
    // Exclusive for vine feature
    private var audioInput: AVCaptureDeviceInput?
    
    override init() {
        super.init()
        setupCaptureSession()
    }
    
    //MARK: SETUP
    func setupCaptureSession() {
        print("CAMERA STATUS: setting up capture session...")
        
        // Ensure this runs on the main thread
        DispatchQueue.main.async {
            self.captureSession.beginConfiguration()
            
            // Get the default video device
            guard let device = AVCaptureDevice.default(for: .video) else {
                print("No video device found")
                return
            }
            self.captureDevice = device
            
            do {
                let input = try AVCaptureDeviceInput(device: device)
                if self.captureSession.canAddInput(input) {
                    self.captureSession.addInput(input)
                }
                
                //Default to burst
                self.configureBurstSettings()
                
                // Setup the output
                if self.captureSession.canAddOutput(self.videoOutput) {
                    self.captureSession.addOutput(self.videoOutput)
                }
                
                self.captureSession.sessionPreset = .high
                self.captureSession.commitConfiguration()
                
               
                self.captureSession.startRunning()
                print("CAMERA STATUS: capture session running...")
                
            } catch {
                print("Error setting up capture session: \(error)")
            }
        }
    }
    
    func configureBurstSettings() {
        // Adjust settings for burst mode
        guard let device = captureDevice else { return }
        print("CAMERA STATUS: configuring for burst mode... ")
        device.set(frameRate: 9.0)
        burstMode = true
    }
    
    func configureVineSettings() {
        // Adjust settings for vine mode
        guard let device = captureDevice else { return }
        
        // Set up audio input
        guard let audioDevice = AVCaptureDevice.default(for: .audio) else {
            print("No audio device found")
            return
        }
        
        do {
            self.audioInput = try AVCaptureDeviceInput(device: audioDevice)
            if self.captureSession.canAddInput(self.audioInput!) {
                self.captureSession.addInput(self.audioInput!)
            }
        } catch {
            print("Error creating audio input: \(error)")
        }
        
        // Frame rate
        print("CAMERA STATUS: configuring for vine mode... ")
        device.set(frameRate: 30.0)
        burstMode = false
    }
    
    func getPreviewLayer() -> AVCaptureVideoPreviewLayer {
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.videoGravity = .resizeAspectFill
        return previewLayer
    }
    
    //MARK: VINE
    
    func startVineRecording() {
        
        // Set up output URL
        let videoURL = FileManager.default.temporaryDirectory.appendingPathComponent("\(UUID()).mov")
        self.videoURLs.append(videoURL)
        print("DEBUG: local videos or video cut counts \(videoURLs.count)")
        
        // Start recording
        videoOutput.startRecording(to: videoURL, recordingDelegate: self)
        flashlight.permission(on: true)
        self.isRecording = true
        print("CAMERA STATUS: recording...")
    }
    
    func stopVineRecording() {
        print("CAMERA STATUS: ending recording...")
        if videoOutput.isRecording {
            videoOutput.stopRecording()
            flashlight.permission(on: false)
            self.isRecording = false
        }
    }
    
    //MARK: BURST
    
    func startBurstRecording() {
        // Set up output URL
        let videoURL = FileManager.default.temporaryDirectory.appendingPathComponent("\(UUID()).mov")
        self.videoURLs.append(videoURL) //will just be one...
        print("DEBUG: local videos or video cut counts \(videoURLs.count)")
        
        // Start recording
        videoOutput.startRecording(to: videoURL, recordingDelegate: self)
        flashlight.startBurst()
        self.isRecording = true
        print("CAMERA STATUS: recording...")
    }
    
    func stopBurstRecording() {
        print("CAMERA STATUS: ending recording...")
        if videoOutput.isRecording {
            videoOutput.stopRecording()
            flashlight.stopBurst()
            self.isRecording = false
        }
    }
    
    //MARK: OUTPUT
    
    func mergeVideos() async {
        // Log the status indicating the start of the merging process
        let _ = print("CAMERA STATUS: merging videos...")
        
        // Create a mutable composition for the merged video
        let composition = AVMutableComposition()
        // Create a video composition to hold rendering instructions
        let videoComposition = AVMutableVideoComposition()
        // Create an audio mix to handle audio parameters
        let audioMix = AVMutableAudioMix()
        
        // Initialize the starting time for inserting tracks
        var insertTime = CMTime.zero
        // Array to hold video composition instructions
        var instructions = [AVMutableVideoCompositionInstruction]()
        // Array to hold audio input parameters for mixing
        var audioInputs = [AVMutableAudioMixInputParameters]()
        
        // Iterate over each video URL provided
        for videoURL in videoURLs {
            let asset = AVAsset(url: videoURL) // Create an AVAsset from the URL
            print("in each video url...")
            
            // Add video track if available
            if let videoTrack = try? await asset.loadTracks(withMediaType: .video).first {
                // Create a mutable video track in the composition
                let compositionVideoTrack = composition.addMutableTrack(withMediaType: .video, preferredTrackID: kCMPersistentTrackID_Invalid)
                do {
                    // Load the duration of the video track asynchronously
                    let duration = try await asset.load(.duration)
                    // Insert the video track into the composition
                    try compositionVideoTrack?.insertTimeRange(CMTimeRange(start: .zero, duration: duration), of: videoTrack, at: insertTime)
                    
                    // Load the natural size of the video track to handle orientation
                    let videoTrackSize = try await videoTrack.load(.naturalSize)
                    let isPortrait = videoTrackSize.width < videoTrackSize.height // Check if the video is in portrait orientation
                    
                    // Create a new instruction for the video composition
                    let instruction = AVMutableVideoCompositionInstruction()
                    instruction.timeRange = CMTimeRange(start: insertTime, duration: duration)
                    
                    // Create a layer instruction for the video track
                    let layerInstruction = AVMutableVideoCompositionLayerInstruction(assetTrack: compositionVideoTrack!)
                    // Load the preferred transform of the video track for orientation adjustments
                    let preferredTransform = try await videoTrack.load(.preferredTransform)
                    // Apply the preferred transform to the layer instruction
                    layerInstruction.setTransform(preferredTransform, at: .zero)
                    instruction.layerInstructions = [layerInstruction] // Add layer instruction to the video composition instruction
                    
                    instructions.append(instruction) // Append the instruction to the instructions array
                } catch {
                    // Handle errors in inserting the video track
                    print("Error inserting video track: \(error)")
                    return
                }
            }
            
            // Add audio track if available
            if let audioTrack = try? await asset.loadTracks(withMediaType: .audio).first {
                // Create a mutable audio track in the composition
                let compositionAudioTrack = composition.addMutableTrack(withMediaType: .audio, preferredTrackID: kCMPersistentTrackID_Invalid)
                do {
                    // Load the duration of the audio track asynchronously
                    let duration2 = try await asset.load(.duration)
                    // Insert the audio track into the composition
                    try compositionAudioTrack?.insertTimeRange(CMTimeRange(start: .zero, duration: duration2), of: audioTrack, at: insertTime)
                    
                    // Create audio input parameters for mixing
                    let audioInput = AVMutableAudioMixInputParameters(track: compositionAudioTrack)
                    audioInputs.append(audioInput) // Append to the audio inputs array
                } catch {
                    // Handle errors in inserting the audio track
                    print("Error inserting audio track: \(error)")
                    return
                }
            }
            print("made it past audio")
            
            // Update the time to insert the next video based on the current asset's duration
            do {
                let duration = try await asset.load(.duration) // Load duration
                insertTime = CMTimeAdd(insertTime, duration) // Update the insert time
            } catch {
                // Handle errors in loading duration
                print("Error loading duration: \(error)")
            }
        }
        
        // Configure the video composition settings
        videoComposition.renderSize = CGSize(width: 720, height: 1280)  // Set to portrait dimensions
        videoComposition.frameDuration = CMTime(value: 1, timescale: 30) // Set frame rate to 30 fps
        videoComposition.instructions = instructions // Assign the collected instructions to the video composition
        
        // Configure the audio mix with input parameters
        audioMix.inputParameters = audioInputs
        
        // Create an export session for the composition with the highest quality preset
        let exportSession = AVAssetExportSession(asset: composition, presetName: AVAssetExportPresetHighestQuality)!
        print("setting output url...")
        
        // Define the output URL for the merged video file
        let outputURL = FileManager.default.temporaryDirectory.appendingPathComponent("mergedVideo.mov")
        
        // Check if the output file already exists; if so, remove it
        if FileManager.default.fileExists(atPath: outputURL.path) {
            do {
                try FileManager.default.removeItem(at: outputURL)
            } catch {
                print("Failed to remove existing file: \(error)")
            }
        }
        
        // Set the export session parameters
        exportSession.outputURL = outputURL // Output file URL
        exportSession.outputFileType = .mov // Output file type
        exportSession.videoComposition = videoComposition // Assign video composition
        exportSession.audioMix = audioMix // Assign audio mix
        
        // Start the export process asynchronously
        exportSession.exportAsynchronously {
            switch exportSession.status {
            case .completed:
                // Log successful export and clear old video URLs
                print("Merged video saved at: \(outputURL)")
                self.videoURLs = [] // Clear old video URLs
                self.videoURLs.insert(outputURL, at: 0) // Insert new merged video URL
                self.vineVideoProcessed = true // Update processing state
                
            case .failed, .cancelled:
                // Log any errors that occur during export
                print("Export failed: \(String(describing: exportSession.error))")
            default:
                // Log the current export status
                print("Export status: \(exportSession.status)")
            }
        }
    }
    
    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo fileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
        if let error = error {
            print("Error recording video: \(error.localizedDescription)")
        } else {
            //let the post capture view know can fetch the URL, for burst ...
            self.burstVideoDone = true
            print("Video recording finished successfully. File URL: \(fileURL)")
            //start the merge process for vine videos
            if self.vineVideoDone {
                print("call to merge")
                Task {
                    await self.mergeVideos()
                }
            }
        }
    }
}
