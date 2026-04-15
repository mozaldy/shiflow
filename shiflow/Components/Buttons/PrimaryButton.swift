//
//  ChordButton.swift
//  shiflow
//
//  Created by Nicole Clarence on 07/04/26.
//

import Foundation
import SwiftUI
struct PrimaryButton: View {
    var isDisabled: Bool = false
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text("START")
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .foregroundStyle(.white)
        .buttonStyle(.glassProminent)
        .tint(.primaryDarkBrown)
        .bold()
        .disabled(isDisabled)
    }
}

#Preview("Enabled") {
    //PrimaryButton(action: action)
}

#Preview("Disabled") {
    //PrimaryButton(action: action)
}
