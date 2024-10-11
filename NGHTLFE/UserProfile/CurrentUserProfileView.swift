//
//  CurrentUserProfileView.swift
//  NGHTLFE
//
//  Created by Michael Neibauer on 10/8/24.
//

import SwiftUI

struct CurrentUserPageView: View {
    
    @StateObject var vm: CurrentUserPageViewModel
    @State private var showCamera: Bool = false
    @State private var showPost: Bool = false
    
    init(manager: UserManager) {
        let _ = print("INIT STATUS: current user page view...")
        _vm = StateObject(wrappedValue: CurrentUserPageViewModel(manager: manager))
    }
    
    var body: some View {
        ZStack {
            
            //change background color
            //Color.green
            
            VStack {
                ScrollView {
                    ProfileHeader(height: 500, image: "test 1", title: "Emma Emma", subtitle: "Innovator, Photographer, Doer")
                    
                    //posts
                    ForEach(0...10, id: \.self) { _ in
                        // a post cell...
                        ZStack {
                            //the border
                            RoundedRectangle(cornerRadius: 5.0)
                                .fill(Color.black)
                                .frame(height: 50)
                                .shadow(color: .white, radius: 2.0)
                            
                            VStack {
                                HStack {
                                    Text("11:59 PM")
//                                    Text("DEC 7TH")
//                                    Spacer()
//                                    Text("11:59 PM")
                                }
                                .padding()
                            }
                        }
                        //the full screen deal
                        .onTapGesture {
                            showPost = true
                        }
                    }
                    .padding(.horizontal, 5)
                    .padding(.vertical, 5)
                }
                .scrollIndicators(.hidden)
            }
            
            VStack {
                HStack {
                    Spacer()
                    
                    Button {
                        showCamera = true
                    } label: {
                        NewMoon()
                    }
                }
                .padding()
                
                Spacer()
            }
            
        }
        //navigations
        .fullScreenCover(isPresented: $showPost) {
            LazyView { PostView() }
        }
        .fullScreenCover(isPresented: $showCamera) {
            LazyView { CameraView2() }
        }
        .onAppear {
            print("APPEAR STATUS: current user page view...")
        }
        .onDisappear {
            //note: navigating via navigation stack doesn't make the main view disappear or re-appear
            print("DISAPPEAR STATUS: current user page view...")
        }
    }
}
