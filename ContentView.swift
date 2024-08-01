//
//  ContentView.swift
//  editPhoto
//
//  Created by Ivan Maslennikov on 30.07.2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var authViewModel = AuthViewModel()
    @StateObject private var imageViewModel = ImageViewModel()
    @State private var isLogg: Bool = false
    
    @State private var showImagePicker = false
    
    var body: some View {
        NavigationStack {
            VStack {
                if authViewModel.isAuthenticated {
                    Text("User is authenticated")
                        .navigationDestination(isPresented: $showImagePicker) {
                            ImagePicker()
                                .environmentObject(imageViewModel)
                        }
                } else {
                    if authViewModel.isLogginIn {
                        SignInView(authViewModel: authViewModel)
                            .transition(.slide)
                    } else {
                        SignUpView(authViewModel: authViewModel)
                            .transition(.slide)
                    }
                }
            }
            .navigationBarHidden(true)
            .onChange(of: authViewModel.isAuthenticated) { isAuthenticated in
                if isAuthenticated {
                    showImagePicker = true
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
