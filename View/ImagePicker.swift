//
//  ImagePicker.swift
//  editPhoto
//
//  Created by Ivan Maslennikov on 31.07.2024.
//


import SwiftUI
import PhotosUI

struct ImagePicker: View {
    
    @StateObject private var imageViewModel = ImageViewModel()
    @State private var showPicker: Bool = false
    @State private var type: UIImagePickerController.SourceType = .photoLibrary

    var body: some View {
        
        NavigationStack {
            
            
            
            VStack {
                
                if let image = imageViewModel.imageModel.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .scaleEffect(imageViewModel.imageModel.scale)
                        .rotationEffect(imageViewModel.imageModel.rotation)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    Text("Please upload a photo for editing")
                        .foregroundStyle(.gray)
                        .frame(maxWidth: 300, minHeight: 300)
                        .background(Color.secondary.opacity(0.1))
                        .cornerRadius(10)
                }
                
                Spacer()
                
                HStack {
                    
                    
                    
                }.frame(maxWidth: .infinity, minHeight: 50)
                    .background(.white)
                
                
                HStack {
                    Button(action: {
                        type = .photoLibrary
                        showPicker = true
                        print("Setting source type to photoLibrary")
                    }) {
                        Text("Select Photo from gallery")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    
                    Button(action: {
                        if UIImagePickerController.isSourceTypeAvailable(.camera) {
                            type = .camera
                            showPicker = true
                            print("Setting source type to camera")
                        } else {
                            // Handle the case where the camera is not available
                            print("Camera is not available.")
                        }
                    }) {
                        Text("Take Photo")
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
                .padding()
                
                HStack {
                    Button(action: {
                        imageViewModel.saveImageToPhotoLibrary()
                    }) {
                        Text("Save Photo")
                            .padding()
                            .background(Color.orange)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    
                    Button(action: {
                        imageViewModel.resetImage()
                    }) {
                        Text("Reset")
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
                .padding()
                
            }
            .sheet(isPresented: $showPicker) {
                ImagePickerView(sourceType: $type, image: $imageViewModel.imageModel.image)
            }
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    ImagePicker()
}
