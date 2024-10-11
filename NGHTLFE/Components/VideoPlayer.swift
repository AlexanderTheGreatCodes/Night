//
//  VideoPlayer.swift
//  NGHTLFE
//
//  Created by Michael Neibauer on 10/10/24.
//

import SwiftUI
import AVKit

struct VideoPlayerView: View {
    let videoURL: URL
        
        var body: some View {
            // Create an AVPlayer with the URL
            let player = AVPlayer(url: videoURL)
            
            // Configure audio session
            let _ = configureAudioSession()
            
            // Use VideoPlayer to display and control video playback
            VideoPlayer(player: player)
                .onAppear {
                    player.play() // Start playing the video and audio when the view appears
                }
                .onDisappear {
                    player.pause() // Pause the video and audio when the view disappears
                }
        }
    
    func configureAudioSession() {
        do {
            let audioSession = AVAudioSession.sharedInstance()
            try audioSession.setCategory(.playback, mode: .default, options: [])
            try audioSession.setActive(true)
        } catch {
            print("Failed to configure audio session: \(error.localizedDescription)")
        }
    }
}
