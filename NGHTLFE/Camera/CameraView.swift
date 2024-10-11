//
//  CameraView.swift
//  NGHTLFE
//
//  Created by Michael Neibauer on 10/8/24.
//

import SwiftUI

struct CameraView: View {
    //back button
    @Environment(\.presentationMode) var presentationMode
    
    init() {
        let _ = print("INIT STATUS: camera view...")
        //_vm = StateObject(wrappedValue: InboxViewModel(manager: manager))
    }
    
    var body: some View {
        ZStack {
            Text("CameraView")
            
            VStack {
                HStack {
                    Spacer()
                    
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                    .padding()
                }
                
                Spacer()
            }
        }
        .onAppear {
            print("APPEAR STATUS: camera view...")
        }
        .onDisappear {
            print("DISAPPEAR STATUS: camera view...")
        }
    }
}

#Preview {
    CameraView()
}
