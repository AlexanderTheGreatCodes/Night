//
//  InboxView.swift
//  NGHTLFE
//
//  Created by Michael Neibauer on 10/8/24.
//

import SwiftUI

struct InboxView: View {
    
    @StateObject var vm: InboxViewModel
    
    init(manager: UserManager) {
        let _ = print("INIT STATUS: inbox view...")
        _vm = StateObject(wrappedValue: InboxViewModel(manager: manager))
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.green
                    .ignoresSafeArea()
                
                VStack {
                    Text("Inbox View")
                    Text(vm.fetchUserPointless())
                }
            }
        }
        .onAppear {
            print("APPEAR STATUS: inbox view...")
        }
        .onDisappear {
            print("DISAPPEAR STATUS: inbox view...")
        }
    }
}
