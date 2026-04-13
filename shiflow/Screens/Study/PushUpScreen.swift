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
    var chord: Chord
    var onDismiss: () -> Void = {}

    @State private var showExitDialog = false
    @State private var showFinger = false
    @State private var isCountingDown = true

    var body: some View {
        ZStack {
            VStack {
                ZStack {
                    Text(title)
                        .font(.largeTitle)
                        .bold()
                        .padding(.vertical)

                    HStack {
                        DissmissButton {
                            metronome.pauseMetronome()
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
                        Image("\(chord.id.lowercased())_chord").resizable()
                            .frame(width: 300, height: 200)
                            .opacity(showFinger ? 0 : 1)

                        Image("\(chord.id.lowercased())_exercise").resizable()
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

                Spacer()

                HStack {
                    Spacer()
                    Button {
                        path.append(StudyRoute.strum(chord))
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
                    metronome.stopMetronome()
                    showExitDialog = false
                    path = NavigationPath()
                },
                onCancel: {
                    metronome.startMetronome()
                    showExitDialog = false
                }
            )
            .blur(radius: isCountingDown ? 5 : 0)

            if isCountingDown {
                CountdownMessage(type: .fingerPushUp) {
                    withAnimation {
                        isCountingDown = false
                    }
                    metronome.startMetronome()
                }
            }

        }
    }
}

#Preview {
    PushUpScreen(
        path: .constant(NavigationPath()),
        title: "Finger Push Up",
        chord: aMinor
    )
    .environment(MetronomeManager())
}
