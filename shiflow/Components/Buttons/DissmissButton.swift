//
//  ChordButton.swift
//  shiflow
//
//  Created by Nicole Clarence on 07/04/26.
//

import Foundation
import SwiftUI
struct DissmissButton: View {
    
    var body: some View {
        Button(action: {
        }){
            Image(systemName: "xmark")
                .padding(10)
                .background(Color("PrimaryDarkBrown"))
                .foregroundStyle(.white)
                .clipShape(Circle())
                .shadow(radius: 3)
        }
    }
}

#Preview {
    DissmissButton()
}
