//
//  TorchManager.swift
//  NGHTLFE
//
//  Created by Michael Neibauer on 10/10/24.
//
import AVFoundation

final class TorchManager {
    private var isBursting = false
    private let queue = DispatchQueue(label: "com.yourapp.torchQueue")
    
    // Function to control the torch
    func permission(on: Bool) {
        guard let device = AVCaptureDevice.default(for: .video) else { return }
        if device.hasTorch {
            do {
                try device.lockForConfiguration()
                if on {
                    try device.setTorchModeOn(level: AVCaptureDevice.maxAvailableTorchLevel)
                } else {
                    device.torchMode = .off
                }
                device.unlockForConfiguration()
            } catch {
                print("Torch could not be used: \(error)")
            }
        } else {
            print("Torch is not available")
        }
    }
    
    // Start the burst flashing
    func startBurst() {
        isBursting = true
        queue.async {
            while self.isBursting {
                self.permission(on: true)
                usleep(60000) // On duration in microseconds; <100000
                self.permission(on: false)
                usleep(60000) // Off duration in microseconds
            }
            print("DEBUG: Flash End")
        }
    }
    
    // Stop the burst flashing
    func stopBurst() {
        isBursting = false
    }
}
