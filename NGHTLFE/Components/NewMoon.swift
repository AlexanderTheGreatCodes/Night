//
//  NewMoon.swift
//  NGHTLFE
//
//  Created by Michael Neibauer on 10/8/24.
//

import SwiftUI

struct NewMoon: View {
    
    var body: some View {
        Circle()
            .fill(Color.black)
            .frame(width: 80)
            .shadow(color: .nightLifeRed, radius: 5)
    }
}

#Preview {
    NewMoon()
}
