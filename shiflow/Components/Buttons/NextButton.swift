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
    
    var body: some View {
        Button(action: action) {
            Image(systemName: "chevron.right")
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
    //NextButton()
}
