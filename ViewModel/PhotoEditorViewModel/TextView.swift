//
//  TextView.swift
//  editPhoto
//
//  Created by Ivan Maslennikov on 01.08.2024.
//


import SwiftUI

struct TextOverlayView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var image: UIImage?
    @State private var text: String = ""
    @State private var fontSize: CGFloat = 20
    @State private var textColor: Color = .black

    var body: some View {
        VStack {
            TextField("Enter text", text: $text)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())

            Slider(value: $fontSize, in: 10...100) {
                Text("Font Size")
            }
            .padding()

            ColorPicker("Text Color", selection: $textColor)
                .padding()

            Button("Add Text") {
                if let currentImage = image {
                    if let newImage = addTextToImage(image: currentImage, text: text, fontSize: fontSize, color: UIColor(textColor)) {
                        image = newImage
                        dismiss()
                    }
                }
            }
        }
        .padding()
    }

    func addTextToImage(image: UIImage, text: String, fontSize: CGFloat, color: UIColor) -> UIImage? {
        let scaleFactor: CGFloat = 0.05
        let scaledFontSize = min(image.size.width, image.size.height) * scaleFactor * (fontSize / 20)

        UIGraphicsBeginImageContextWithOptions(image.size, false, 0.0)
        defer { UIGraphicsEndImageContext() }

        image.draw(in: CGRect(origin: .zero, size: image.size))

        let textAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: scaledFontSize),
            .foregroundColor: color
        ]

        let textSize = text.size(withAttributes: textAttributes)
        let textRect = CGRect(
            x: (image.size.width - textSize.width) / 2,
            y: (image.size.height - textSize.height) / 2,
            width: textSize.width,
            height: textSize.height
        )

        text.draw(in: textRect, withAttributes: textAttributes)

        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
