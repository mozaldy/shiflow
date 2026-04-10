//
//  FingerPushUpScreen.swift
//  shiflow
//
//  Created by Mohammad Rizaldy Ramadhan on 09/04/26.
//

import SwiftUI

struct FingerPushUpScreen: View {
    @EnvironmentObject private var router: PracticeRouter
    @StateObject private var beat = BeatTimer(bpm: 60)

    @State private var isExerciseActive = false
    @State private var showFinger = false
    @State private var fingerToggleTimer: Timer?

    private let beatsPerBar: Int = 4

    private var beatInBar: Int {
        ((beat.beatCount - 1) % beatsPerBar) + 1
    }

    var body: some View {
        ZStack {
            PracticeScreenLayout(activeTab: .pushUp, beat: beat, onNext: {
                router.navigate(to: .moonWalk)
            }) {
                HStack(spacing: 16) {
                    ZStack {
                        Image("am_chord")
                            .resizable()
                            .frame(width: 300, height: 200)
                            .opacity(showFinger ? 0 : 1)

                        Image("am_exercise")
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
            }
            .onAppear {
                startFingerToggleTimer()
            }
            .onDisappear {
                stopFingerToggleTimer()
                beat.stop()
            }
            
            if !isExerciseActive {
                CountdownMessage(type: .fingerPushUp, tempo: beat.bpm) {
                    withAnimation {
                        isExerciseActive = true
                    }
                    beat.start()
                }
            }
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
    FingerPushUpScreen()
        .environmentObject(PracticeRouter())
}
