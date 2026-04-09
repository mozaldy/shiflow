//
//  ChordButton1.swift
//  shiflow
//
//  Created by Nicole Clarence on 08/04/26.
//

import SwiftUI

struct ChordButton: View {
    var chordTitle: String
    
    var body: some View {
        
        Text("\(chordTitle)")
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(Color.primaryDarkBrown)
            .foregroundStyle(.white)
            .clipShape(Circle())
            .bold()
            .shadow(radius: 3)
        }
    }

#Preview {
    ChordButton(chordTitle: "A")
}
