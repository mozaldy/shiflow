//
//  FingerMoonWalkScreen.swift
//  shiflow
//
//  Created by Mohammad Rizaldy Ramadhan on 09/04/26.
//

import SwiftUI

struct FingerMoonWalkScreen: View {
    @Environment(MetronomeManager.self) private var metronome

    @State private var strumTriggerA: Int = 0
    @State private var strumTriggerB: Int = 0
    
    let chordA: Chord
    let chordB: Chord

    var body: some View {
        VStack(spacing: 20) {

            HStack(spacing: 16) {
                // Chord A column
                VStack(spacing: 8) {
                    Text(chordA.name)
                        .font(.headline)
                        .foregroundStyle(metronome.isEvenBar ? .primaryDarkBrown : .primaryLightBrown)
                    TabsGuitar(chord: chordA, isActive: metronome.isEvenBar)
                }
                VStack(spacing: 24) {
                    BeatIndicator(currentBeat: metronome.beatInBar, totalBeats: metronome.beatsPerMeasure, isPlaying: metronome.isPlaying)
                    TempoView(manager: metronome)
                }

                // Chord B column
                VStack(spacing: 8) {
                    Text(chordB.name)
                        .font(.headline)
                        .foregroundStyle(!metronome.isEvenBar ? .primaryDarkBrown : .primaryLightBrown)
                    TabsGuitar(chord: chordB, isActive: !metronome.isEvenBar)
                }
            }


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
    FingerMoonWalkScreen(chordA: aMinor, chordB: dMajor)
        .environment(MetronomeManager())
}
