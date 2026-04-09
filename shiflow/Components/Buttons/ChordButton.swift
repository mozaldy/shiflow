//
//  ChordButton1.swift
//  shiflow
//
//  Created by Nicole Clarence on 08/04/26.
//

import SwiftUI

struct ChordButton: View {
    var chordTitle: Chord
    var isDisabled: Bool = false
    var action: () -> Void
    
    var body: some View {
        
        Button(action: action){
            Text(chordTitle.id)
        }
        .frame(minWidth: 33)
        .padding(.horizontal, 8)
        .padding(.vertical, 8)
        .background(isDisabled ? Color.gray : Color.primaryDarkBrown)
        .clipShape(Circle())
        .disabled(isDisabled)
        .foregroundStyle(.white)
        .bold()
        .shadow(radius: 3)
        
    }
}

#Preview {
    ChordButton(chordTitle: aMajor) {
    
    }
}
