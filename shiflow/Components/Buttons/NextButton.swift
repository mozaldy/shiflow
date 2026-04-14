//
//  ChordButton.swift
//  shiflow
//
//  Created by Nicole Clarence on 07/04/26.
//

import Foundation
import SwiftUI
struct NextButton: View {
    var action: () -> Void
    
    var isDisabled: Bool = false
    
    var body: some View {
        Button(action: action) {
            Image(systemName: "chevron.right")
                .padding(10)
                .background(isDisabled ? Color.gray : Color.primaryDarkBrown)
                .foregroundStyle(.white)
                .clipShape(Circle())
                .bold()
                .shadow(radius: 3)
        }
        .disabled(isDisabled)
        .opacity(isDisabled ? 0.3 : 1.0)
    }
}

#Preview {
    NextButton(action: {})
    NextButton(action: {}, isDisabled: true)
}
