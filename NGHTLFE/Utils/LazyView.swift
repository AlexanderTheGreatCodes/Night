//
//  LazyView.swift
//  NGHTLFE
//
//  Created by Michael Neibauer on 10/8/24.
//

import SwiftUI

struct LazyView<Content: View>: View {
    let content: () -> Content
    
    var body: some View {
        content()
    }
}
