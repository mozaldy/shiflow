//
//  ChordButton.swift
//  shiflow
//
//  Created by Nicole Clarence on 07/04/26.
//

import Foundation
import SwiftUI
struct DissmissButton: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        Button(action: {
            dismiss()
        }) {
            Image(systemName: "xmark")
                .padding(10)
                .background(Color.primaryDarkBrown)
                .foregroundStyle(.white)
                .clipShape(Circle())
                .bold()
                .shadow(radius: 3)
        }
    }
}

#Preview {
    DissmissButton()
}
