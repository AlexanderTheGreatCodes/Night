//
//  SignUpView.swift
//  NGHTLFE
//
//  Created by Michael Neibauer on 10/11/24.
//

import SwiftUI

struct SignUpView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var vm: SignUpViewModel
    
    init(manager: UserManager) {
        let _ = print("INIT STATUS: sign up view...")
        _vm = StateObject(wrappedValue: SignUpViewModel(manager: manager))
    }
    
    var body: some View {
        VStack {
            
            HStack {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "chevron.backward")
                        .foregroundColor(.white)
                }
                
                Spacer()
            }
            
            Spacer()
            
            Text("Create your Account.")
                .font(.title)
                .fontWeight(.heavy)
            
            //I kind of want NightLife in cursive ...
            
            VStack {
                TextField("Email...", text: $vm.email)
                    .padding()
                    .background(Color.gray.opacity(0.4))
                    .cornerRadius(10)
                
                SecureField("Password...", text: $vm.password)
                    .padding()
                    .background(Color.gray.opacity(0.4))
                    .cornerRadius(10)
                
                TextField("Name (optional)", text: $vm.name)
                    .padding()
                    .background(Color.gray.opacity(0.4))
                    .cornerRadius(10)
                
                TextField("Bio (optional)", text: $vm.bio)
                    .padding()
                    .background(Color.gray.opacity(0.4))
                    .cornerRadius(10)
            }
            
            Button {
                Task {
                    do {
                        try await vm.signUp()
                    } catch {
                        print("DEBUG SIGN UP VIEW: ", error)
                    }
                }
            } label: {
                Text("Sign Up")
                    .font(.headline)
                    .foregroundColor(.black)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .cornerRadius(10)
            }
            .padding(.vertical)
            
            Spacer()
            
        }
        .padding()
        .navigationBarBackButtonHidden(true)
    }
}

@MainActor
final class SignUpViewModel: ObservableObject {
    @ObservedObject var manager: UserManager
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var name: String = ""
    @Published var bio: String = ""
    
    init(manager: UserManager) {
        self.manager = manager
    }
    
    @MainActor
    func signUp() async throws {
        //is there an email and password that was passed through to the view model?
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found.")
            return
        }
        //if yes, try and create user...
        try await manager.createUser(email: email, password: password, name: name, bio: bio)
    }
}

//#Preview {
//    SignUpView(showSignInView: .constant(true))
//}
