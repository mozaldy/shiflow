//
//  FingerPushUpScreen.swift
//  shiflow
//
//  Created by Mohammad Rizaldy Ramadhan on 09/04/26.
//

import SwiftUI

struct FingerPushUpScreen: View {
    let chordA: Chord
    let chordB: Chord
    @ObservedObject var beat: BeatTimer

    @State private var showFinger = false
    @State private var fingerToggleTimer: Timer?

    private let beatsPerBar: Int = 4

    private var beatInBar: Int {
        ((beat.beatCount - 1) % beatsPerBar) + 1
    }

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
                    currentBeat: beatInBar,
                    totalBeats: beatsPerBar,
                    isPlaying: beat.isPlaying
                )
                BPMControls(beat: beat)
            }
        }
        .onAppear {
            startFingerToggleTimer()
        }
        .onDisappear {
            stopFingerToggleTimer()
        }
    }

    private func startFingerToggleTimer() {
        fingerToggleTimer?.invalidate()
        fingerToggleTimer = Timer.scheduledTimer(withTimeInterval: 4, repeats: true) { _ in
            withAnimation {
                showFinger.toggle()
            }
        }
    }

    private func stopFingerToggleTimer() {
        fingerToggleTimer?.invalidate()
        fingerToggleTimer = nil
    }
}

#Preview {
    FingerPushUpScreen(chordA: aMinor, chordB: dMajor, beat: BeatTimer(bpm: 60))
}
