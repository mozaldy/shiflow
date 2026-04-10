//
//  FingerRapidFireScreen.swift
//  shiflow
//
//  Created by Mohammad Rizaldy Ramadhan on 09/04/26.
//

import SwiftUI

struct FingerRapidFireScreen: View {
    @ObservedObject var beat: BeatTimer

    @State private var strumTriggerA: Int = 0
    @State private var strumTriggerB: Int = 0

    let chordA: Chord
    let chordB: Chord

    private let beatsPerBar: Int = 4

    private var barIndex: Int {
        max(0, (beat.beatCount - 1) / beatsPerBar)
    }

    private var isChordAActive: Bool {
        barIndex % 2 == 0
    }

    private var beatInBar: Int {
        ((beat.beatCount - 1) % beatsPerBar) + 1
    }

    private var isFirstBeatOfBar: Bool {
        beatInBar == 1
    }

    var body: some View {
        VStack {

            HStack(spacing: 0) {
                // Chord A column
                VStack(spacing: 8) {
                    Text(chordA.name)
                        .font(.subheadline)
                        .foregroundStyle(isChordAActive ? .primaryDarkBrown : .primaryLightBrown)
                    TabsGuitar(chord: chordA, isActive: isChordAActive)
                    StrumGuitar(chord: chordA, isActive: isChordAActive, strumTrigger: strumTriggerA, isDownStrum: barIndex % 2 == 0)
                }

                
                VStack {
                BeatIndicator(currentBeat: beatInBar, totalBeats: beatsPerBar, isPlaying: beat.isPlaying)
                
                BPMControls(beat: beat)
                }
                // Chord B column
                VStack(spacing: 8) {
                    Text(chordB.name)
                        .font(.subheadline)
                        .foregroundStyle(!isChordAActive ? .primaryDarkBrown : .primaryLightBrown)
                    TabsGuitar(chord: chordB, isActive: !isChordAActive)
                    StrumGuitar(chord: chordB, isActive: !isChordAActive, strumTrigger: strumTriggerB, isDownStrum: barIndex % 2 == 0)
                }
            }
            .environment(\.guitarSize, .small)


        }
        .padding()
        .onChange(of: beat.beatCount) {
            guard isFirstBeatOfBar else { return }
            if isChordAActive {
                strumTriggerA += 1
            } else {
                strumTriggerB += 1
            }
        }
    }
}

#Preview {
    FingerRapidFireScreen(beat: BeatTimer(bpm: 80), chordA: aMinor, chordB: dMajor)
}
