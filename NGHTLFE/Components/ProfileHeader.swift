//
//  ProfileHeader.swift
//  NGHTLFE
//
//  Created by Michael Neibauer on 10/8/24.
//

import SwiftUI

struct ProfileHeader: View {
    
    let height: CGFloat
    let image: String
    let title: String
    let subtitle: String
    
    init(height: CGFloat, image: String, title: String, subtitle: String) {
        self.height = height
        self.image = image
        self.title = title
        self.subtitle = subtitle
    }
    
    var body: some View {
            Rectangle()
            .opacity(0)
            .overlay(
                Image(image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    //.vignetteEffect(startRadius: 0, endRadius: 400)
            )
            .overlay(
                VStack(alignment: .leading, spacing: 8) {
                    Text(subtitle)
                        .font(.headline)
                    Text(title)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
                    .foregroundStyle(.white)
                    .padding(16)
                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .background(
//                        LinearGradient(colors: [shadowColor.opacity(0), shadowColor], startPoint: .top, endPoint: .bottom)
//                    )
                , alignment: .bottomLeading
            )
            .asStretchyHeader(startingHeight: height)
    }
}

//#Preview {
//    ProfileHeader()
//}
 
