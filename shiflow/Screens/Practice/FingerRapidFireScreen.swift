//
//  FingerRapidFireScreen.swift
//  shiflow
//
//  Created by Mohammad Rizaldy Ramadhan on 09/04/26.
//

import SwiftUI

struct FingerRapidFireScreen: View {
    @Environment(MetronomeManager.self) private var metronome
    @StateObject private var beat = BeatTimer(bpm: 80)

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
                    .padding(.trailing, 5)
                    .padding(.top, 12)

                    
                    VStack {
                        BeatIndicator(currentBeat: beatInBar, totalBeats: metronome.beatsPerMeasure, isPlaying: metronome.isPlaying)
                    
                    Text("BPM :")
                    Text("\(Int(metronome.tempo))")
                    //BPMControls(beat: beat)
                    }
                    // Chord B column
                    VStack(spacing: 8) {
                        Text(chordB.name)
                            .font(.subheadline)
                            .foregroundStyle(!isChordAActive ? .primaryDarkBrown : .primaryLightBrown)
                        TabsGuitar(chord: chordB, isActive: !isChordAActive)
                        StrumGuitar(chord: chordB, isActive: !isChordAActive, strumTrigger: strumTriggerB, isDownStrum: barIndex % 2 == 0)
                    }
                    .padding(.leading, 5)
                    .padding(.top, 12)
                }
                .environment(\.guitarSize, .small)


            }
            //.padding()
            .onAppear {
                beat.start()
            }
            .onDisappear {
                beat.stop()
            }
            .onChange(of: metronome.beatCount) {
                guard metronome.currentBeat == 1 else { return }
                if isChordAActive {
                    strumTriggerA += 1
                } else {
                    strumTriggerB += 1
                }
            }
        }
    }


#Preview {
    FingerRapidFireScreen(chordA: aMajor, chordB: dMajor)
        .environment(MetronomeManager())
}
