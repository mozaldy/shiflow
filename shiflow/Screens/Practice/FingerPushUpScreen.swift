//
//  FingerPushUpScreen.swift
//  shiflow
//
//  Created by Mohammad Rizaldy Ramadhan on 09/04/26.
//

import SwiftUI

struct FingerPushUpScreen: View {
    @Environment(MetronomeManager.self) private var metronome

    @State private var showFinger = false

    let chordA: Chord
    let chordB: Chord

    private var chordImageName: String {
        switch chordA.id.lowercased() {
        case "am": return "am_chord"
        case "d": return "d_chord"
        default: return "am_chord"
        }
    }

    private var exerciseImageName: String {
        switch chordA.id.lowercased() {
        case "am": return "am_exercise"
        case "d": return "d_exercise"
        default: return "am_exercise"
        }
    }

    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                Image(chordImageName)
                    .resizable()
                    .frame(width: 300, height: 200)
                    .opacity(showFinger ? 0 : 1)

                Image(exerciseImageName)
                    .resizable()
                    .frame(width: 300, height: 200)
                    .opacity(showFinger ? 1 : 0)
            }

            VStack(spacing: 24) {
                BeatIndicator(
                    currentBeat: metronome.beatInBar,
                    totalBeats: metronome.beatsPerMeasure,
                    isPlaying: metronome.isPlaying
                )
                TempoView(manager: metronome)
            }
        }
        .onChange(of: metronome.beatCount) {
            if metronome.isFirstBeatOfBar {
                withAnimation {
                    showFinger.toggle()
                }
            }
        }
    }
}

#Preview {
    FingerPushUpScreen(chordA: aMinor, chordB: dMajor)
        .environment(MetronomeManager())
}
