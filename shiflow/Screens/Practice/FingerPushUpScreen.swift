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

    var body: some View {
        ZStack {
            PracticeScreenLayout(activeTab: .pushUp, beat: beat, onNext: {
                router.navigate(to: .moonWalk)
            }) {
                VStack {
                    Text("Push Up Content Goes Here")
                        .font(.headline)
                        .foregroundStyle(.primaryDarkBrown)
                }
            }
            .onDisappear {
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
}

#Preview {
    FingerPushUpScreen()
        .environmentObject(PracticeRouter())
}
