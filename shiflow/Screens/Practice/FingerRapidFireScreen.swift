//
//  FingerRapidFireScreen.swift
//  shiflow
//
//  Created by Mohammad Rizaldy Ramadhan on 09/04/26.
//

import SwiftUI

struct FingerRapidFireScreen: View {
    @Environment(MetronomeManager.self) private var metronome

    @State private var strumTriggerA: Int = 0
    @State private var strumTriggerB: Int = 0

    let chordA: Chord
    let chordB: Chord


    var body: some View {
        VStack {

            HStack(spacing: 0) {
                // Chord A column
                VStack(spacing: 8) {
                    Text(chordA.name)
                        .font(.subheadline)
                        .foregroundStyle(metronome.isEvenBar ? .primaryDarkBrown : .primaryLightBrown)
                    TabsGuitar(chord: chordA, isActive: metronome.isEvenBar)
                    StrumGuitar(chord: chordA, isActive: metronome.isEvenBar, strumTrigger: strumTriggerA)
                }

                
                VStack {
                    BeatIndicator(currentBeat: metronome.beatInBar, totalBeats: metronome.beatsPerMeasure, isPlaying: metronome.isPlaying)
                
                TempoView(manager: metronome)
                }
                // Chord B column
                VStack(spacing: 8) {
                    Text(chordB.name)
                        .font(.subheadline)
                        .foregroundStyle(!metronome.isEvenBar ? .primaryDarkBrown : .primaryLightBrown)
                    TabsGuitar(chord: chordB, isActive: !metronome.isEvenBar)
                    StrumGuitar(chord: chordB, isActive: !metronome.isEvenBar, strumTrigger: strumTriggerB)
                }
            }
            .environment(\.guitarSize, .small)


        }
        .padding()
        .onChange(of: metronome.beatCount) {
            guard metronome.isFirstBeatOfBar else { return }
            if metronome.isEvenBar {
                strumTriggerA += 1
            } else {
                strumTriggerB += 1
            }
        }
    }
}

#Preview {
    FingerRapidFireScreen(chordA: aMinor, chordB: dMajor)
        .environment(MetronomeManager())
}
