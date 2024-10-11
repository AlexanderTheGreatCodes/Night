//
//  FeedView.swift
//  NGHTLFE
//
//  Created by Michael Neibauer on 10/8/24.
//

import SwiftUI

struct FeedView: View {
    
    @StateObject var vm: FeedViewModel
    
    init(manager: UserManager) {
        let _ = print("INIT STATUS: feed view...")
        _vm = StateObject(wrappedValue: FeedViewModel(manager: manager))
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.blue
                    .ignoresSafeArea()
                
                VStack {
                    Text("Feed View")
                    Text(vm.fetchUserPointless())
                }
            }
        }
        .onAppear {
            print("APPEAR STATUS: feed view...")
        }
        .onDisappear {
            print("DISAPPEAR STATUS: feed view...")
        }
    }
}
