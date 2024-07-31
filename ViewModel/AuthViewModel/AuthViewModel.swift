//
//  AuthViewModel.swift
//  editPhoto
//
//  Created by Ivan Maslennikov on 30.07.2024.
//

import SwiftUI
import FirebaseAuth
import GoogleSignIn
import FirebaseCore
import Combine

class AuthViewModel: ObservableObject {
    
    @Published var user: User = User()
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    @Published var isLogginIn: Bool = false
    @Published var isAuthenticated = false
    
    func signUpWithEmail() {
        guard isValidEmail(user.email) else {
            alertMessage = "Invalid email!"
            showAlert = true
            return
        }
        
        guard user.password.count > 6 else {
            alertMessage = "Password must be at least 6 characters long"
            showAlert = true
            return
        }
        
        Auth.auth().createUser(withEmail: user.email, password: user.password) { authResult, error in
            if let error = error {
                self.alertMessage = error.localizedDescription
                self.showAlert = true
                return
            }
            
            authResult?.user.sendEmailVerification { error in
                if let error = error {
                    self.alertMessage = error.localizedDescription
                    self.showAlert = true
                    return
                }
                self.alertMessage = "Verification email sent"
                self.showAlert = true
            }
            
            print("User registered successfully: \(authResult?.user.email ?? "")")
        }
    }
    
    func signInWithEmail() {
        guard isValidEmail(user.email) else {
            alertMessage = "Invalid email!"
            showAlert = true
            return
        }
        
        Auth.auth().signIn(withEmail: user.email, password: user.password) { authResult, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.alertMessage = error.localizedDescription
                    self.showAlert = true
                    return
                }
                self.isAuthenticated = true
                self.isLogginIn = true
                print("User \(authResult?.user.email ?? "") signed in!")
            }
        }
    }
    
    func resetPassword() {
        guard isValidEmail(user.email) else {
            alertMessage = "Invalid email!"
            showAlert = true
            return
        }
        
        Auth.auth().sendPasswordReset(withEmail: user.email) { error in
            if let error = error {
                self.alertMessage = error.localizedDescription
                self.showAlert = true
                return
            }
            self.alertMessage = "Password reset email sent"
            self.showAlert = true
        }
    }
    
    func signInWithGoogle(presenting: UIViewController) {
        guard (FirebaseApp.app()?.options.clientID) != nil else { return }
        
        GIDSignIn.sharedInstance.signIn(withPresenting: presenting) { result, error  in
            DispatchQueue.main.async {
                if let error = error {
                    self.alertMessage = error.localizedDescription
                    self.showAlert = true
                    return
                }

                guard
                    let user = result?.user,
                    let idToken = user.idToken else {
                    self.alertMessage = "Google authentication failed"
                    self.showAlert = true
                    return
                }

                let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString,
                                                               accessToken: user.accessToken.tokenString)
                
                Auth.auth().signIn(with: credential) { [weak self] authResult, error in
                    DispatchQueue.main.async {
                        if let error = error {
                            self?.alertMessage = error.localizedDescription
                            self?.showAlert = true
                            return
                        }
                        self?.isAuthenticated = true
                        self?.isLogginIn = true
                        print("User signed in with Google: \(authResult?.user.email ?? "")")
                    }
                }
            }
        }
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
