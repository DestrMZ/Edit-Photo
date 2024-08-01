//
//  ResetPasswordView.swift
//  editPhoto
//
//  Created by Ivan Maslennikov on 31.07.2024.
//

import SwiftUI

struct ResetPasswordView: View {
    
    @ObservedObject var authViewModel: AuthViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 15) {
            
            Text("Reset Password")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 15)
            
            TextField("Email", text: $authViewModel.user.email)
                .padding()
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .background(RoundedRectangle(cornerRadius: 6).stroke(Color.blue, lineWidth: 2))
                .padding(.horizontal, 15)
            
            Button(action: {
                authViewModel.resetPassword()
            }) {
                Text("Send Reset Link")
                    .frame(maxWidth: 200)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding(.top, 20)
            
            Spacer()
            
            Button(action: {
                dismiss()
            }) {
                Text("Cancel")
                    .foregroundColor(.blue)
            }
            .padding(.bottom, 20)
        }
        .padding(.horizontal, 20)
        .alert(isPresented: $authViewModel.showAlert) {
            Alert(title: Text("Message"), message: Text(authViewModel.alertMessage), dismissButton: .default(Text("OK")))
        }
    }
}

#Preview {
    ResetPasswordView(authViewModel: AuthViewModel())
}
