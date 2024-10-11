//
//  CustomizeTabBar.swift
//  NGHTLFE
//
//  Created by Michael Neibauer on 10/11/24.
//

import Foundation
import SwiftUI

func customizeTabBar() {
    let appearance = UITabBarAppearance()
    appearance.configureWithOpaqueBackground()
    appearance.stackedLayoutAppearance.normal.iconColor = .white
    appearance.stackedLayoutAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    
    appearance.stackedLayoutAppearance.selected.iconColor = UIColor(Color.nightLifeRed)
    appearance.stackedLayoutAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(Color.nightLifeRed)]
    
    UITabBar.appearance().standardAppearance = appearance
    UITabBar.appearance().scrollEdgeAppearance = appearance
}
