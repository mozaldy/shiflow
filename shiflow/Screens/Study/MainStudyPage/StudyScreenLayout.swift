//
//  MainStudyPage.swift
//  shiflow
//
//  Created by Theressa Natasha Thebez on 08/04/26.
//

import Foundation
import SwiftUI

enum StudyRoute: Hashable {
    case finger(Chord)
    case pushup(Chord)
    case strum(Chord)
}

struct MainStudyScreen: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var path: NavigationPath
    @State var selectedChord: Chord

    let chords = [aMinor, cMajor, dMajor, fMajor, eMinor, gMajor]

    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Button {
                    dismiss()
                } label: {
                    BackButton()
                }

                Picker("Chord", selection: $selectedChord) {
                    ForEach(chords, id: \.self) { chord in
                        Text(chord.id).tag(chord)
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
                        path.append(StudyRoute.finger(selectedChord))
                    }
                )

                ChordCard(
                    imageName: getChordImage(type: "exercise"),
                    title: "Finger Push Up Exercise",
                    action: {
                        path.append(StudyRoute.pushup(selectedChord))
                    }
                )

                ChordCard(
                    imageName: getChordImage(type: "strum"),
                    title: "How to Strum",
                    action: {
                        path.append(StudyRoute.strum(selectedChord))
                    }
                )
            }
            .frame(maxWidth: .infinity, alignment: .center)

            Button {
                path.append(StudyRoute.finger(selectedChord))
            } label: {
                Text("Start")
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color("PrimaryDarkBrown"))
                    .foregroundStyle(.white)
                    .clipShape(Capsule())
                    .bold()
                    .shadow(radius: 3)
            }
            .frame(maxWidth: .infinity, alignment: .center)
        }
        .navigationBarBackButtonHidden(true)
        .navigationDestination(for: StudyRoute.self) { route in
            switch route {
            case .finger(let chord):
                FingerPositionScreen(
                    path: $path,
                    title: "Finger Position",
                    chord: chord
                )
            case .pushup(let chord):
                PushUpScreen(
                    path: $path,
                    title: "Finger Push Up",
                    chord: chord
                )
            case .strum(let chord):
                StrumScreen(
                    path: $path,
                    title: "How to Strum",
                    chord: chord
                )
            }
        }
    }
}

#Preview {
    NavigationStack {
        MainStudyScreen(
            path: .constant(NavigationPath()),
            selectedChord: aMinor
        )
    }
}
