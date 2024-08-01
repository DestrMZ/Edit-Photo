//
//  ImagePicker.swift
//  editPhoto
//
//  Created by Ivan Maslennikov on 31.07.2024.
//


import SwiftUI

struct ImagePicker: View {
    
    @StateObject private var imageViewModel = ImageViewModel()
    @State private var showPicker: Bool = false
    @State private var type: UIImagePickerController.SourceType = .photoLibrary
    @State private var showTextView = false

    @State private var lastScale: CGFloat = 1.0
    @State private var lastRotation: Angle = .zero
    
    var body: some View {
        NavigationStack {
            
            Spacer()
            
            VStack {
                if let image = imageViewModel.imageModel.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .scaleEffect(imageViewModel.imageModel.scale)
                        .rotationEffect(imageViewModel.imageModel.rotation)
                        .frame(maxWidth: .infinity, maxHeight: 400)
                        .border(Color.gray, width: 2)
                        .cornerRadius(10)
                        .padding()
                        .gesture(
                            SimultaneousGesture(
                                MagnificationGesture()
                                    .onChanged { value in
                                        let newScale = value / lastScale * imageViewModel.imageModel.scale
                                        imageViewModel.scaleImage(newScale)
                                        lastScale = value
                                    }
                                    .onEnded { _ in
                                        lastScale = 1.0
                                    },
                                RotationGesture()
                                    .onChanged { value in
                                        let newRotation = value - lastRotation + imageViewModel.imageModel.rotation
                                        imageViewModel.rotationImage(newRotation)
                                        lastRotation = value
                                    }
                                    .onEnded { _ in
                                        lastRotation = .zero
                                    }
                            )
                        )
                } else {
                    Text("Please upload a photo for editing")
                        .foregroundStyle(.gray)
                        .frame(maxWidth: 300, minHeight: 300)
                        .background(Color.secondary.opacity(0.1))
                        .cornerRadius(10)
                }
                
                Spacer()
                
            }
            .sheet(isPresented: $showPicker) {
                if type == .photoLibrary {
                    ImagePickerView(sourceType: $type, image: $imageViewModel.imageModel.image)
                } else {
                    ImagePickerView(sourceType: $type, image: $imageViewModel.imageModel.image)
                }
            }
            .sheet(isPresented: $showTextView) {
                TextOverlayView(image: $imageViewModel.imageModel.image)
            }
            .navigationBarHidden(true)
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    HStack {
                        Button(action: {
                            type = .photoLibrary
                            showPicker = true
                            print("Setting source type to photoLibrary")
                        }) {
                            Image(systemName: "plus")
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            showTextView = true
                        }) {
                            Image(systemName: "plus.message.fill")
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                                type = .camera
                                showPicker = true
                                print("Setting source type to camera")
                            } else {
                                print("Camera is not available.")
                            }
                        }) {
                            Image(systemName: "camera")
                        }
                    }
                    .padding()
                }
            }
        }
    }
}

#Preview {
    ImagePicker()
}
