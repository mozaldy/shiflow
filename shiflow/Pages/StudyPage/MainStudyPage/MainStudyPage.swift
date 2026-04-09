//
//  MainStudyPage.swift
//  shiflow
//
//  Created by Theressa Natasha Thebez on 08/04/26.
//

import Foundation
import SwiftUI

struct MainStudyPage: View {
    @State var selectedChord = "Am"
    let chords = ["Am", "C", "D", "F", "Em", "G"]
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            HStack {
                Button {
                    dismiss()
                } label: {
                    HStack {
                        Image(systemName: "arrow.backward")
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 16)
                    .background(.brown)
                    .foregroundStyle(.white)
                    .clipShape(Capsule())
                }
                
                Picker("Chord", selection: $selectedChord) {
                    ForEach(chords, id: \.self) { chord in
                        Text(chord)
                    }
                }
                .pickerStyle(.segmented)
                .frame(width: 650)
            }
            .padding(.horizontal)
            
            HStack(spacing: 22) {
                ChordCard(
                    imageName: getChordImage(type: "finger"),
                    title: "Finger Position",
                    destination: FingerPositionPage(title:"Finger Position \(selectedChord)")
                )
                
                ChordCard(
                    imageName: getChordImage(type: "exercise"),
                    title: "Finger Push Up Exercise",
                    destination: PushUpPage(title: "Exercise \(selectedChord)")
                )
                
                ChordCard(
                    imageName: getChordImage(type: "strum"),
                    title: "How to Strum",
                    destination: StrumPage(title: "Strum \(selectedChord)")
                )
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.leading, 50)
        }
    }
}

#Preview {
    NavigationStack {
        MainStudyPage()
    }
}
