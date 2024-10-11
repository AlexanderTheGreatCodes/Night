//
//  PostView.swift
//  NGHTLFE
//
//  Created by Michael Neibauer on 10/8/24.
//

import SwiftUI

struct PostView: View {
    
    @Environment(\.presentationMode) var presentationMode
    //@ObservedObject var viewModel: PostViewModel
    
    
    init() {
        let _ = print("INIT STATUS: post view...")
        //_vm = StateObject(wrappedValue: InboxViewModel(manager: manager))
    }
    
    var body: some View {
        ZStack {
            
            
            
            
            Image("test 1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width)
                .clipShape(
                    Rectangle()
                )
                .ignoresSafeArea()
                //swipe up on the image to dismiss...
                .gesture(GestureHelper.swipeUpToDismissGesture(presentationMode: presentationMode))
            
            
            VStack {
                
                HStack {
                    
                    Menu {
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Text("Delete Post")
                                .foregroundStyle(.red)
                        }
                    } label: {
                        Image(systemName: "ellipsis")
                            .foregroundStyle(.white)
                    }
                    .padding(.leading)
                    
                    Spacer()
                    
                    Text("1:03 AM")
                        .font(.title)
                        .fontWeight(.ultraLight)
                        .offset(x: -15)
                    
                    Spacer()
                    
                }
                
                Spacer()
                
            }
            
        }
    }
}

