//
//  PushUpPage.swift
//  shiflow
//
//  Created by Theressa Natasha Thebez on 08/04/26.
//

import Foundation
import SwiftUI

struct PushUpScreen: View {
    @Environment(MetronomeManager.self) private var metronome
    @Binding var path: NavigationPath

    var title: String
    var chord: String
    var onDismiss: () -> Void = {}

    @State private var showExitDialog = false
    @State private var showFinger = false
    @State private var strumTriggerA: Int = 0

    let chordA = aMinor

    var body: some View {
        VStack {
            ZStack {
                Text(title)
                    .font(.largeTitle)
                    .bold()
                    .padding(.vertical)

                HStack {
                    DissmissButton {
                        showExitDialog = true
                    }
                    .padding(.leading, 40)

                    Spacer()
                }
                .ignoresSafeArea()
            }
            .padding(.vertical, 15)

            HStack(spacing: 16) {
                ZStack {
                    Image("\(chord.lowercased())_chord").resizable()
                        .frame(width: 300, height: 200)
                        .opacity(showFinger ? 0 : 1)

                    Image("\(chord.lowercased())_exercise").resizable()
                        .frame(width: 300, height: 200)
                        .opacity(showFinger ? 1 : 0)
                }
                .onAppear {
                    Timer.scheduledTimer(
                        withTimeInterval: 4,
                        repeats: true
                    ) {
                        _ in
                        withAnimation {
                            showFinger.toggle()
                        }
                    }
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
            .onAppear {
                metronome.startMetronome()
            }
            .onDisappear {
                metronome.stopMetronome()
            }
            .onChange(of: metronome.beatCount) {
                guard metronome.isFirstBeatOfBar else { return }
                if metronome.isEvenBar {
                    strumTriggerA += 1
                }

            }
            Spacer()

            HStack {
                Spacer()
                Button {
                    path.append("strum-\(chord)")
                } label: {
                    Text("Next")
                        .font(.headline)
                        .padding(.horizontal, 30)
                        .padding(.vertical, 12)
                        .background(Color.brown)
                        .foregroundStyle(.white)
                        .clipShape(Capsule())
                }
            }
        }
        .padding(.bottom)
        .navigationBarBackButtonHidden(true)
        .exitDialog(
            isPresented: $showExitDialog,
            onExit: {
                showExitDialog = false
                path = NavigationPath()
            },
            onCancel: {
                showExitDialog = false
            }
        )
    }
}

#Preview {
    PushUpScreen(
        path: .constant(NavigationPath()),
        title: "Finger Push Up",
        chord: "am"
    )
    .environment(MetronomeManager())
}
