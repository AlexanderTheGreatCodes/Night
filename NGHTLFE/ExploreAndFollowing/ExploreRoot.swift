//
//  ExpAndFollowingRoot.swift
//  NGHTLFE
//
//  Created by Michael Neibauer on 10/9/24.
//

import SwiftUI

struct ExploreRoot: View {
    
    //@StateObject private var viewModel = ExFViewModel()
    @State private var isExplore = true
//    @State private var showPost = false
//    @State private var showComments = false
//    @State private var showUserProfile = false
//    
//    @State private var isFollowingLoading = true
    
    var body: some View {
        VStack {
            header
            
            //i think they're both going to be just tiktok paging...
            if isExplore {
                ExploreView()
            } else {
                FollowingView()
            }
            
            Spacer()
            
        }
    }
    
    var header: some View {
        HStack {
            Button {
                isExplore = true
            } label : {
                ZStack {
                    Rectangle()
                        .fill(Color(UIColor.systemBackground))
                    
                    Text("Explore")
                        .foregroundColor(Color.white)
                        .font(.headline)
                        .fontWeight(.heavy)
                }
            }
            .frame(width: UIScreen.main.bounds.width/2, height: 60)
            
            Button {
                isExplore = false
            } label: {
                ZStack {
                    Rectangle()
                        .fill(Color(UIColor.systemBackground))
                    
                    Text("Following")
                        .foregroundColor(Color.white)
                        .font(.headline)
                        .fontWeight(.heavy)
                }
            }
            .frame(width: UIScreen.main.bounds.width/2, height: 60)
        }
    }
}


