//
//  SignInView.swift
//  NightLife
//
//  Created by Michael Neibauer on 8/20/24.
//

import SwiftUI

struct SignInView: View {
    @StateObject private var vm: SignInViewModel
    
    init(manager: UserManager) {
        let _ = print("INIT STATUS: sign in view...")
        _vm = StateObject(wrappedValue: SignInViewModel(manager: manager))
    }
    
    var body: some View {
        //idea - a background of flashing photos...
        
        VStack {
            
            Spacer()
            
            Text("Welcome to NightLife!")
                .font(.title)
                .fontWeight(.heavy)
            
            VStack {
                TextField("Email...", text: $vm.email)
                    .padding()
                    .background(Color.gray.opacity(0.4))
                    .cornerRadius(10)
                
                SecureField("Password...", text: $vm.password)
                    .padding()
                    .background(Color.gray.opacity(0.4))
                    .cornerRadius(10)
            }
            
            Button {
                Task {
                    do {
                        try await vm.signIn()
                    } catch {
                        print("DEBUG SIGN IN VIEW: ", error)
                    }
                }
            } label: {
                Text("Sign In")
                    .font(.headline)
                    .foregroundColor(.black)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .cornerRadius(10)
            }
            .padding(.vertical)
            
            HStack {
                Text("Don't have an account?")
                
                NavigationLink("Join the Party.", destination:
                    LazyView{ SignUpView(manager: vm.manager) }
                )
                .foregroundColor(.red)
            }
            
            Spacer()
            
        }
        .padding()
    }
}

@MainActor
final class SignInViewModel: ObservableObject {
    
    @ObservedObject var manager: UserManager
    
    @Published var email: String = ""
    @Published var password: String = ""
    
    init(manager: UserManager) {
        self.manager = manager
    }
    
    func signIn() async throws {
        //is there an email and password that was passed through to the view model?
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found.")
            return
        }
        //if yes, try and create user...
        let _ = try await manager.login(withEmail: email, password: password)
    }
}

//#Preview {
//    NavigationStack {
//        SignInView()
//    }
//}
