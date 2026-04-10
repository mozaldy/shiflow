//
//  FingerMoonWalkScreen.swift
//  shiflow
//
//  Created by Mohammad Rizaldy Ramadhan on 09/04/26.
//

import SwiftUI

struct FingerMoonWalkScreen: View {
    @Environment(MetronomeManager.self) private var metronome
    @StateObject private var beat = BeatTimer(bpm: 60)

    @State private var strumTriggerA: Int = 0
    @State private var strumTriggerB: Int = 0
    
    let chordA: Chord
    let chordB: Chord

    private let beatsPerBar: Int = 4

    private var barIndex: Int {
        max(0, (metronome.beatCount - 1) / metronome.beatsPerMeasure)
    }

    private var isChordAActive: Bool {
        barIndex % 2 == 0
    }

    private var beatInBar: Int {
        metronome.currentBeat
    }

    private var isFirstBeatOfBar: Bool {
        beatInBar == 1
    }

    var body: some View {
            VStack(spacing: 20) {
                HStack(spacing: 16) {
                    // Chord A column
                    VStack(spacing: 8) {
                        Text(chordA.name)
                            .font(.headline)
                            .foregroundStyle(isChordAActive ? .primaryDarkBrown : .primaryLightBrown)
                        TabsGuitar(chord: chordA, isActive: isChordAActive)
                    }
                    VStack(spacing: 24) {
                        BeatIndicator(currentBeat: beatInBar, totalBeats: metronome.beatsPerMeasure, isPlaying: metronome.isPlaying)
                        // BPMControls(beat: beat)
                    }

                    // Chord B column
                    VStack(spacing: 8) {
                        Text(chordB.name)
                            .font(.headline)
                            .foregroundStyle(!isChordAActive ? .primaryDarkBrown : .primaryLightBrown)
                        TabsGuitar(chord: chordB, isActive: !isChordAActive)
                    }
                }


            }
            .padding()
//            .onAppear {
//                beat.start()
//            }
//            .onDisappear {
//                beat.stop()
//            }
//            .onChange(of: beat.beatCount) {
//                guard isFirstBeatOfBar else { return }
//                if isChordAActive {
//                    strumTriggerA += 1
//                } else {
//                    strumTriggerB += 1
//                }
//            }
        }
    
}

#Preview {
    FingerMoonWalkScreen(chordA: aMajor, chordB: dMajor)
        .environment(MetronomeManager())
}
