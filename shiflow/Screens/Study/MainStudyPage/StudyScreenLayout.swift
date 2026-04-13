//
//  MainStudyPage.swift
//  shiflow
//
//  Created by Theressa Natasha Thebez on 08/04/26.
//

import Foundation
import SwiftUI

struct MainStudyScreen: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var path: NavigationPath
    @State var selectedChord: String

    let chords = ["Am", "C", "D", "F", "Em", "G"]

    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "arrow.backward")
                        .padding(.horizontal, 16)
                        .padding(.vertical, 18)
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
                .padding(.leading)
            }
            .padding(.top, 10)
            .padding(.leading, -75)

            HStack(spacing: 22) {
                ChordCard(
                    imageName: getChordImage(type: "finger"),
                    title: "Finger Position",
                    action: {
                        path.append("finger-\(selectedChord)")
                    }
                )

                ChordCard(
                    imageName: getChordImage(type: "exercise"),
                    title: "Finger Push Up Exercise",
                    action: {
                        path.append("pushup-\(selectedChord)")
                    }
                )

                ChordCard(
                    imageName: getChordImage(type: "strum"),
                    title: "How to Strum",
                    action: {
                        path.append("strum-\(selectedChord)")
                    }
                )
            }
            .frame(maxWidth: .infinity, alignment: .center)

            Button {
                path.append("finger")
            } label: {
                Text("Start")
                    .font(.headline)
                    .padding(.horizontal, 40)
                    .padding(.vertical, 10)
                    .background(Color.brown)
                    .foregroundStyle(.white)
                    .clipShape(Capsule())
            }
            .frame(maxWidth: .infinity, alignment: .center)
        }
        .navigationBarBackButtonHidden(true)
        .navigationDestination(for: String.self) { value in
            if value.contains("finger") {
                let chord = value == "finger" ? selectedChord : value.replacingOccurrences(of: "finger-", with: "")
                FingerPositionScreen(path: $path, title: "Finger Position", chord: chord)
            } else if value.contains("pushup") {
                let chord = value.replacingOccurrences(of: "pushup-", with: "")
                PushUpScreen(path: $path, title: "Finger Push Up", chord: chord)
            } else if value.contains("strum") {
                let chord = value.replacingOccurrences(of: "strum-", with: "")
                StrumScreen(path: $path, title: "How to Strum", chord: chord)
            }
        }
    }
}

#Preview {
    NavigationStack {
        MainStudyScreen(
            path: .constant(NavigationPath()),
            selectedChord: "Am"
        )
    }
}
