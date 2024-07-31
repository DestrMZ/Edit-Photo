//
//  SignInView.swift
//  editPhoto
//
//  Created by Ivan Maslennikov on 30.07.2024.
//
// Регистрация нового пользователя


import SwiftUI

struct SignInView: View {
    
    @ObservedObject var authViewModel: AuthViewModel
    @State private var showResetPasswordSheet = false
    let borderColor = Color(red: 107.0/255.0, green: 164.0/255.0, blue: 252.0/255.0) // random
    
    var body: some View {
        
        VStack(spacing: 15) {
            
            Text("Sign in to your account")
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
            HStack {
                Spacer()
                
                Button(action: {
                    showResetPasswordSheet = true
                }) {
                    Text("Forget Password")
                        .fontWeight(.semibold)
                        .foregroundColor(Color.blue)
                }
                .sheet(isPresented: $showResetPasswordSheet) {
                    ResetPasswordView(authViewModel: authViewModel)
                }
                .padding(.top, 5)
                .padding(.trailing, 15)
            }
            
            Button(action: {
                authViewModel.signInWithEmail()
            }) {
                Text("Sign In")
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
                Text("Don't have an account?")
                
                NavigationLink(destination: SignUpView(authViewModel: authViewModel)) {
                    Text("Sign up")
                        .fontWeight(.bold)
                        .foregroundColor(Color.blue)
                }
                
                Text("now")
                    .multilineTextAlignment(.leading)
            }
            .padding(.bottom, 20)
            .alert(isPresented: $authViewModel.showAlert) {
                Alert(title: Text("Message"), message: Text(authViewModel.alertMessage), dismissButton: .default(Text("OK")))
            }
        }
//        .padding(.horizontal, 20)
    }


#Preview {
    SignInView(authViewModel: AuthViewModel())
}
