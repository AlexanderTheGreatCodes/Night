//
//  Test.swift
//  NGHTLFE
//
//  Created by Michael Neibauer on 10/9/24.
//


//MARK: BUGGY AS SHIT

import Foundation
import SwiftUI

struct Test: View {
    @State private var selectedTab = 0
    //MARK: IMPORTANT
    //you would PRELOAD YOUR VIEW MODELS HERE...
    //load view models here ... don't do anything crazy in your view inits...

    var body: some View {
        ZStack {
            
//            Color.red
//            
            if selectedTab == 0 {
                FirstView()
            } else if selectedTab == 1 {
                 SecondView()
            } else if selectedTab == 2 {
                ThirdView()
            }
            
            // Hidden Page Control
//            HStack {
//                Button(action: { selectedTab = 0 }) { Text("First") }
//                Button(action: { selectedTab = 1 }) { Text("Second") }
//                Button(action: { selectedTab = 2 }) { Text("Third") }
//            }
            
            Color.red
                .opacity(0)
            
        }
        .gesture(DragGesture()
            .onEnded { value in
                if value.translation.width < 0 {
                    selectedTab = min(selectedTab + 1, 2) // swipe left
                } else if value.translation.width > 0 {
                    selectedTab = max(selectedTab - 1, 0) // swipe right
                }
            }
        )
    }
}

struct FirstView: View {
    
    init() {
        print("INIT STATUS: first view...")
    }
    
    var body: some View {
        ZStack {
            Color.blue
            
            Text("HELLO 1")
        }
        .onAppear {
            print("APPEAR STATUS: first view...")
        }
    }
}

struct SecondView: View {
    
    init() {
        print("INIT STATUS: second view...")
    }
    
    var body: some View {
        VStack {
            Text("HELLO 2")
        }
        .onAppear {
            print("APPEAR STATUS: second view...")
        }
    }
}
struct ThirdView: View {
    
    init() {
        print("INIT STATUS: third view...")
    }
    
    var body: some View {
        VStack {
            Text("HELLO 3")
        }
        .onAppear {
            print("APPEAR STATUS: third view...")
        }
    }
}
