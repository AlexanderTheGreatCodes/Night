//
//  VideoButton.swift
//  NGHTLFE
//
//  Created by Michael Neibauer on 10/10/24.
//

import SwiftUI


//MARK: pass in a bool and change color depending on what you want...
struct VideoButton: View {
    @Binding var percentRecorded: CGFloat  //1.0 -> end
    
    init(percentRecorded: Binding<CGFloat>) {
        print("INIT STATUS: video button...")
        self._percentRecorded = percentRecorded
    }
    
    var body: some View {
 
        let video_red = Color(red: 0.75, green: 0.0, blue: 0.0)
        
        ZStack {
            
            Circle()
                .trim(from: percentRecorded, to: 1.0)
                .stroke(lineWidth: 10)
                .fill(video_red)
                .frame(width: 110)
                .shadow(color: video_red, radius: 5)
            
            Circle()
                .fill(Color.black)
                .frame(width: 100)
            
        }
    }
}
