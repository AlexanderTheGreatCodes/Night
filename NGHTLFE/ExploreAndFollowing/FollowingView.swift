//
//  FollowingView.swift
//  NGHTLFE
//
//  Created by Michael Neibauer on 10/10/24.
//

import SwiftUI

struct FollowingView: View {
//    var body: some View {
        //@EnvironmentObject var viewModel: ExFViewModel
        //@Binding var showUserProfile: Bool
        //@Binding var showComments: Bool
        
        var body: some View {
            ScrollView(showsIndicators: false) {
                LazyVStack (spacing: 0) {
                    ForEach(0...100, id: \.self) { _ in
                        //let localPost = viewModel.followingPosts[index]
                        
                        ZStack {
                            Image("test 1")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: UIScreen.main.bounds.width)
                                .clipShape(
                                    Rectangle()
                                )
                                .onAppear {
                                    print("DEBUG: loading a post for following.")
                                    //eh...
                                }
                            
                            VStack {
                                
                                Text("11:59 PM")
                                    .font(.title2)
                                    .fontWeight(.ultraLight)
                                    .padding(.vertical, 5)
                                
                                
                                
                                Spacer()
                                
//                                HStack {
//                                    Button {
//                                        showUserProfile = true
//                                    } label: {
//                                        Text(localPost.postUserName)
//                                            .foregroundColor(.white)
//                                            .font(.title)
//                                            .fontWeight(.bold)
//                                            .multilineTextAlignment(.leading)
//                                    }
//                                    
//                                    Spacer()
//                                    
//                                    Button {
//                                        showComments = true
//                                    } label: {
//                                        FullMoon()
//                                    }
//                                }
                                .padding(.horizontal, 20)
                                .padding(.vertical, 20)
                            }
                            
                        }
                        .containerRelativeFrame(.vertical, alignment: .center)
                        .scrollTransition { content, phase in
                            content
                                .opacity(phase.isIdentity ? 1.0 : 0.0)
                        }
                    }
                    .scrollTargetLayout()
                }
                
            }
            .ignoresSafeArea()
            .scrollTargetBehavior(.paging)
        }
    
}

#Preview {
    FollowingView()
}
