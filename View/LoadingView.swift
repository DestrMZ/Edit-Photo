//
//  LoadingView.swift
//  editPhoto
//
//  Created by Ivan Maslennikov on 31.07.2024.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            ProgressView("Loading...")
                .progressViewStyle(CircularProgressViewStyle())
                .scaleEffect(1.0)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
        .shadow(radius: 10)
    }
}

#Preview {
    LoadingView()
}
