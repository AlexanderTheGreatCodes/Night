//
//  GestureHelper.swift
//  NGHTLFE
//
//  Created by Michael Neibauer on 10/9/24.
//

import SwiftUI

struct GestureHelper {
    static func swipeUpToDismissGesture(presentationMode: Binding<PresentationMode>) -> some Gesture {
        DragGesture()
            .onEnded { gesture in
                if gesture.translation.height > 40 {
                    let _ = print("DEBUG: swipe gesture up to dismiss...")
                    presentationMode.wrappedValue.dismiss()
                }
            }
    }
    
    static func swipeRightToDismissGesture(presentationMode: Binding<PresentationMode>) -> some Gesture {
        DragGesture()
            .onEnded { gesture in
                if gesture.translation.width > 40 {
                    presentationMode.wrappedValue.dismiss()
                }
            }
    }
}
