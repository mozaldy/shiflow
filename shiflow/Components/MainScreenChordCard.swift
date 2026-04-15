//
//  MainScreenChordCard.swift
//  shiflow
//
//  Created by Mohammad Rizaldy Ramadhan on 13/04/26.
//
import SwiftUI
import Foundation


struct MainScreenChordCard: View {
    @Binding var selectedChord: Chord?
    
    var body: some View {
        RoundedRectangle(cornerSize: CGSize(width: 30, height: 30), style: .circular)
            .frame(maxWidth: 250, maxHeight: 225)
            .foregroundStyle(.primaryWhite)
            .shadow(radius: 5)
            .overlay {
                if let chord = selectedChord {
                    Text(chord.id)
                        .font(.system(size: 128, weight: .black, design: .monospaced))
                        .foregroundStyle(.primaryDarkBrown)
                } else {
                    Text("Select a chord")
                        .font(.headline)
                        .foregroundStyle(.gray)
                }
            }
            .overlay(alignment: .topTrailing) {
                if selectedChord != nil {
                    Button {
                        selectedChord = nil
                    } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 16))
                            .foregroundStyle(.white)
                            .padding(8)
                            .background(Circle().fill(.red))
                    }
                    .padding(10)
                }
            }
    }
}

#Preview {
    HStack {
        MainScreenChordCard(selectedChord: .constant(aMinor))
        MainScreenChordCard(selectedChord: .constant(nil))
    }
}
