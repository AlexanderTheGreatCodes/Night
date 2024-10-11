//
//  VignetteEffect.swift
//  NGHTLFE
//
//  Created by Michael Neibauer on 10/8/24.
//

import SwiftUI

struct RadialGradientOverlay: ViewModifier {
    var startRadius: CGFloat = 0
    var endRadius: CGFloat = 250

    func body(content: Content) -> some View {
        content
            .overlay(
                RadialGradient(
                    gradient: Gradient(colors: [Color.clear, Color.black]),
                    center: .center,
                    startRadius: startRadius,
                    endRadius: endRadius
                )
            )
    }
}

extension View {
    func vignetteEffect(startRadius: CGFloat, endRadius: CGFloat) -> some View {
        self.modifier(RadialGradientOverlay(startRadius: startRadius, endRadius: endRadius))
    }
}
