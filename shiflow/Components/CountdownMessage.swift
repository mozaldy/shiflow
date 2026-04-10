//
//  CountdownMessage.swift
//  shiflow
//
//  Created by Devon on 07/04/26.
//

import SwiftUI
import AVFoundation
internal import Combine

enum ExerciseType {
    case fingerPushUp
    case moonwalk
    case rapidFire
    
    var title: String {
        switch self {
        case .fingerPushUp:
            return "You're about to start the Finger Push-Up"
        case .moonwalk:
            return "You're about to start the Moonwalk (Switching Chords)"
        case .rapidFire:
            return "You're about to start the Rapid Fire"
        }
    }
    
    var subtitle: String {
        switch self {
        case .fingerPushUp:
            return "Hold and release your finger placement according to the tempo"
        case .moonwalk:
            return "Keep your fingers moving, don't stop. Let the muscle memory take over"
        case .rapidFire:
            return "Watch the metronome and switch chords while strumming it"
        }
    }
}

struct CountdownMessage: View {
    let type: ExerciseType
    var tempo: Double
    var onFinished: () -> Void
    
    @State var showMessage = true
    @State var showCountdown = false
    @State var countdownNumber = 3
    
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            if showMessage {
                // Message start
                instructionOverlay
            }
            
            if showCountdown {
                countdownOverlay(number: countdownNumber)
            }
        }
        // Timer logic
        .onReceive(timer) { _ in
            guard showCountdown else { return } // Jalan kalau countdown aktif
            
            if countdownNumber > 1 {
                withAnimation {
                    countdownNumber -= 1
                }
                AudioServicesPlaySystemSound(1104)
            } else if countdownNumber == 1 {
                withAnimation {
                    countdownNumber -= 1
                }
                AudioServicesPlaySystemSound(1022)
            } else {
                withAnimation {
                    showCountdown = false
                }
                onFinished()
                countdownNumber = 3 // reset
            }
        }
    }
    private var instructionOverlay: some View {
        //let type: ExerciseType
        
        ZStack {
            Color.black.opacity(0.6)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                Text(type.title)
                    .font(.largeTitle)
                    .bold()
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.primaryWhite)
                    .padding(.bottom, 4)
                Text(type.subtitle)
                    .font(.callout)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.primaryWhite)
                Spacer()
                Text("Tap to continue")
                    .font(.caption)
                    .italic()
                    .opacity(0.6)
                    .foregroundStyle(.primaryWhite)
            }
        }
        // Tap to continue
        .onTapGesture {
            // Play sound angka 3
            AudioServicesPlaySystemSound(1104)
            
            // Reset timer
            timer = Timer.publish(every: 60.0/tempo, on: .main, in: .common).autoconnect()
            showMessage = false
            showCountdown = true
        }
    }
    
    @ViewBuilder
    private func countdownOverlay(number: Int) -> some View {
        ZStack {
            Color.black.opacity(0.6)
                .ignoresSafeArea()
            
            Text(number > 0 ? "\(number)" : "GO!")
                .font(.system(size: 100, weight: .bold))
                .foregroundStyle(.primaryLightBrown)
                .transition(.opacity)
                .id(number)
        }
    }
}


// Contoh penggunaan
#Preview {
    @Previewable @State var isExerciseActive = false
    
    ZStack {
        Text("Exercise Guitar")
        
        if !isExerciseActive {
            CountdownMessage(type: .fingerPushUp, tempo: 120) {
                withAnimation {
                    isExerciseActive = true
                }
            }
        }
    }
}
