//
//  SignUpView.swift
//  editPhoto
//
//  Created by Ivan Maslennikov on 30.07.2024.
//

import SwiftUI

struct SignUpView: View {
    
    @ObservedObject var authViewModel: AuthViewModel
    let borderColor = Color(red: 107.0/255.0, green: 164.0/255.0, blue: 252.0/255.0)
    
    var body: some View {
        
        VStack(spacing: 15) {
            
            Text("Sign up to your account")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 15)
                
            TextField("Email", text: $authViewModel.user.email)
                .padding()
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .background(RoundedRectangle(cornerRadius: 6).stroke(borderColor, lineWidth: 2))
                .padding(.horizontal, 15)
            
            SecureField("Password", text: $authViewModel.user.password)
                .padding()
                .background(RoundedRectangle(cornerRadius: 6).stroke(borderColor, lineWidth: 2))
                .padding(.horizontal, 15)
        }
        
        Button(action: {
            authViewModel.signUpWithEmail()
        }) {
            Text("Sign Up")
                .frame(maxWidth: 200)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
        }
        .padding(.top, 20)
        
        Spacer()
        
        Button(action: {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                let window = windowScene.windows.first {
                authViewModel.signInWithGoogle(presenting: window.rootViewController!)
                        }
                    }) {
                    HStack {
                        Image(.google)
                            .resizable()
                            .frame(width: 30, height: 30)
                            .padding(.leading, 20)
                            
                        Text("Sign in with Google")
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding()
                        }
                        .background(Color.gray)
                        .cornerRadius(8)
                    }
                    .padding(.bottom, 10)
        
        HStack(spacing: 5) {
            Text("Already have an account?")
            
            NavigationLink(destination: SignInView(authViewModel: authViewModel)) {
                Text("Sign In")
                    .fontWeight(.bold)
                    .foregroundColor(Color.blue)
            }
            
            Text("now")
        }
        .padding(.bottom, 25)
        .alert(isPresented: $authViewModel.showAlert) {
            Alert(title: Text("Message"), message: Text(authViewModel.alertMessage), dismissButton: .default(Text("OK")))
        }
    }
}


#Preview {
    SignUpView(authViewModel: AuthViewModel())
}
