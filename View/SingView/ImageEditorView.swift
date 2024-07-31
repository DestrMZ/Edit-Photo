//
//  ImageEditorView.swift
//  editPhoto
//
//  Created by Ivan Maslennikov on 01.08.2024.
//

import SwiftUI

struct ImageEditorView: View {
    @StateObject private var viewModel = ImageViewModel()
    @State private var scale: CGFloat = 1.0
    @State private var rotation: Angle = .zero
    @State private var lastScale: CGFloat = 1.0
    @State private var lastRotation: Angle = .zero
    
    var body: some View {
        VStack {
            if let image = viewModel.imageModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .scaleEffect(scale)
                    .rotationEffect(rotation)
                    .gesture(
                        MagnificationGesture()
                            .onChanged { value in
                                let delta = value / lastScale
                                scale *= delta
                                lastScale = value
                            }
                            .onEnded { value in
                                viewModel.scaleImage(scale)
                                lastScale = 1.0
                            }
                    )
                    .gesture(
                        RotationGesture()
                            .onChanged { value in
                                let delta = value - lastRotation
                                rotation += delta
                                lastRotation = value
                            }
                            .onEnded { value in
                                viewModel.rotationImage(rotation)
                                lastRotation = .zero
                            }
                    )
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                Text("Please upload a photo for editing")
                    .foregroundStyle(.gray)
                    .frame(maxWidth: 300, minHeight: 300)
                    .background(Color.secondary.opacity(0.1))
                    .cornerRadius(10)
            }
            
            HStack {
                Button(action: {
                    viewModel.saveImageToPhotoLibrary()
                }) {
                    Text("Save Photo")
                        .padding()
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                
                Button(action: {
                    viewModel.resetImage()
                    scale = 1.0
                    rotation = .zero
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
        .navigationTitle("Edit Photo")
    }
}

#Preview {
    ImageEditorView()
}
