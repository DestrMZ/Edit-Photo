//
//  EditorViewModel.swift
//  editPhoto
//
//  Created by Ivan Maslennikov on 31.07.2024.
//


import SwiftUI

class ImageViewModel: ObservableObject {
    
    @Published var imageModel = ImageModel()
    @Published var selectedImage: UIImage?
    
    func setImage(_ image: UIImage) {
        imageModel.image = image
        selectedImage = image
    }
    
    func scaleImage(_ scale: CGFloat) {
        imageModel.scale = scale
    }
    
    func rotationImage(_ angle: Angle) {
        imageModel.rotation = angle
    }
    
    func resetImage() {
        imageModel.scale = 1.0
        imageModel.rotation = .zero
        if let originalImage = selectedImage {
            imageModel.image = originalImage
        }
    }
    
    func saveImageToPhotoLibrary() {
        guard let image = imageModel.image else { return }
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }
}

