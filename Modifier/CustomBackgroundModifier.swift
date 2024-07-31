//
//  SwiftUIView.swift
//  editPhoto
//
//  Created by Ivan Maslennikov on 30.07.2024.
//

import SwiftUI

struct CustomTextField: ViewModifier {
    let borderColor: Color
    
    func body(content: Content) -> some View {
        content
            .padding()
            .background(RoundedRectangle(cornerRadius: 6).stroke(borderColor, lineWidth: 2))
            .padding(.horizontal, 5)
    }
}

extension View {
    func customTextFieldStyle(borderColor: Color) -> some View {
        self.modifier(CustomTextField(borderColor: borderColor))
    }
}
