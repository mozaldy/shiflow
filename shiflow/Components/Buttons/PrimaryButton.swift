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

    var body: some View {
        Text("START")
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(isDisabled ? Color.gray : Color("PrimaryDarkBrown"))
            .foregroundStyle(.white)
            .clipShape(Capsule())
            .bold()
            .opacity(isDisabled ? 0.5 : 1.0)
            .disabled(isDisabled)
            .shadow(radius: 3)
    }
}

#Preview("Enabled") {
    PrimaryButton()
}

#Preview("Disabled") {
    PrimaryButton(isDisabled: true)
}
