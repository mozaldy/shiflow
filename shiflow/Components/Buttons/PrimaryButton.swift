//
//  ChordButton.swift
//  shiflow
//
//  Created by Nicole Clarence on 07/04/26.
//

import Foundation
import SwiftUI
struct PrimaryButton: View {

    var body: some View {
        Text("Button")
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(.brown)
            .foregroundStyle(.white)
            .clipShape(Capsule())
    }
}

#Preview {
    PrimaryButton()
}
