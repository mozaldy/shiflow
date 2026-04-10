//
//  ExerciseContainerView.swift
//  shiflow
//
//  Created by Jose Putra Perdana Taneo on 10/04/26.
//

import Foundation
import SwiftUI

struct ExerciseContainerView: View {
    @Environment(MetronomeManager.self) private var metronome
    @Environment(\.dismiss) private var dismiss
    @StateObject private var pushUpBeat = BeatTimer(bpm: 60)
    @StateObject private var moonWalkBeat = BeatTimer(bpm: 60)
    @StateObject private var rapidFireBeat = BeatTimer(bpm: 80)
    
    @State private var currentTab: PracticeTab = .pushUp
    @State private var isCountingDown = true
    @State private var isFinished = false
    @State private var showingExitDialog = false
    
    let chordA: Chord
    let chordB: Chord

    private var currentBeat: BeatTimer {
        switch currentTab {
        case .pushUp:
            return pushUpBeat
        case .moonWalk:
            return moonWalkBeat
        case .rapidFire:
            return rapidFireBeat
        }
    }
    
    var body: some View {
        ZStack {
            if isFinished {
                VStack(spacing: 20) {
                    Text("Well Done! 🎉")
                        .font(.largeTitle)
                        .bold()
                    Button("Back to main page") {
                        dismiss()
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.primaryDarkBrown)
                }
            } else {
                // Tampilan berdasarkan tab aktif
                PracticeScreenLayout(
                    activeTab: currentTab,
                    beat: currentBeat,
                    onNext: moveToNextStep,
                    onDismiss: {
                        pauseCurrentExercise()
                        showingExitDialog = true
                    }
                ) {
                    displayContent(for: currentTab)
                }
                .blur(radius: showingExitDialog ? 5 : 0)
                
                if isCountingDown {
                    CountdownMessage(
                        type: getExerciseType(for: currentTab)
                    ) {
                        withAnimation { isCountingDown = false }
                        currentBeat.start()
                    }
                }
            }
        }
        .onDisappear {
            stopAllExerciseTimers()
            metronome.stopMetronome()
        }
        .exitDialog(
            isPresented: $showingExitDialog,
            onExit: {
                stopAllExerciseTimers()
                metronome.stopMetronome()
                dismiss()
            },
            onCancel: {
                showingExitDialog = false
                currentBeat.start()
            })
    }

    private func pauseCurrentExercise() {
        currentBeat.stop()
        metronome.pauseMetronome()
    }

    private func stopAllExerciseTimers() {
        pushUpBeat.stop()
        moonWalkBeat.stop()
        rapidFireBeat.stop()
    }
    
    private func getExerciseType(for step: PracticeTab) -> ExerciseType {
        switch step {
        case .pushUp: return .fingerPushUp
        case .moonWalk: return .moonwalk
        case .rapidFire: return .rapidFire
        }
    }
    
    private func moveToNextStep() {
        currentBeat.stop()
        metronome.stopMetronome()
        
        let allSteps = PracticeTab.allCases
        if let currentIndex = allSteps.firstIndex(of: currentTab) {
            let nextIndex = currentIndex + 1
            
            if nextIndex < allSteps.count {
                // Pindah ke latihan berikutnya
                currentTab = allSteps[nextIndex]
                isCountingDown = true
            } else {
                // kalau udah exercise terakhir
                isFinished = true
            }
        }
    }
    
    @ViewBuilder
    private func displayContent(for tab: PracticeTab) -> some View {
        switch tab {
        case .pushUp:
            FingerPushUpScreen(chordA: chordA, chordB: chordB, beat: pushUpBeat)
            
        case .moonWalk:
            FingerMoonWalkScreen(beat: moonWalkBeat, chordA: chordA, chordB: chordB)
            
        case .rapidFire:
            FingerRapidFireScreen(beat: rapidFireBeat, chordA: chordA, chordB: chordB)
        }
    }
}
