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
    @Binding var isPresented: Bool
    
    @State private var currentTab: PracticeTab = .pushUp
    @State private var isCountingDown = true
    @State private var isFinished = false
    @State private var showingExitDialog = false
    
    let chordA: Chord
    let chordB: Chord
    
    var body: some View {
        ZStack {
            if isFinished {
                VStack(spacing: 20) {
                    Text("Well Done! 🎉")
                        .font(.largeTitle)
                        .bold()
                    Button("Back to main page") {
                        isPresented = false
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.primaryDarkBrown)
                }
            } else {
                // Tampilan berdasarkan tab aktif
                PracticeScreenLayout(
                    activeTab: currentTab,
                    onNext: moveToNextStep,
                    onDismiss: {
                        metronome.pauseMetronome()
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
                        metronome.startMetronome()
                    }
                }
            }
        }
        .onDisappear {
            metronome.stopMetronome()
        }
        .exitDialog(
            isPresented: $showingExitDialog,
            onExit: {
                metronome.stopMetronome()
                isPresented = false
            },
            onCancel: {
                showingExitDialog = false
                metronome.startMetronome()
            })
    }
        
    
    private func startNextStep(_ next: PracticeTab) {
        metronome.stopMetronome() // Berhenti
        currentTab = next
        isCountingDown = true // Muncul countdown lagi
    }
    
    private func getExerciseType(for step: PracticeTab) -> ExerciseType {
        switch step {
        case .pushUp: return .fingerPushUp
        case .moonWalk: return .moonwalk
        case .rapidFire: return .rapidFire
        }
    }
    
    private func moveToNextStep() {
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
            FingerPushUpScreen(chordA: chordA, chordB: chordB)
            
        case .moonWalk:
            FingerMoonWalkScreen(chordA: chordA, chordB: chordB)
            
        case .rapidFire:
            FingerRapidFireScreen(chordA: chordA, chordB: chordB)
        }
    }
}
