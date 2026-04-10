//
//  PushUpPage.swift
//  shiflow
//
//  Created by Theressa Natasha Thebez on 08/04/26.
//

import Foundation
import SwiftUI

struct PushUpScreen: View {
    @Binding var path: NavigationPath
    var title: String
    var chord: String

    @State private var showExitDialog = false
    @State private var showFinger = false
    @StateObject private var beat = BeatTimer(bpm: 60)

    private let beatsPerBar: Int = 4

    private var beatInBar: Int {
        ((beat.beatCount - 1) % beatsPerBar) + 1
    }

    var body: some View {
        VStack {
            Text(title)
                .font(.largeTitle)
                .bold()
                .padding(.vertical)

            VStack {
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
                            currentBeat: beatInBar,
                            totalBeats: beatsPerBar,
                            isPlaying: beat.isPlaying
                        )
                        BPMControls(beat: beat)
                    }
                }

            }
            .onAppear {
                beat.start()
            }
            .onDisappear {
                beat.stop()
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
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    showExitDialog = true
                } label: {
                    Image(systemName: "xmark")
                }
            }
        }
        .exitDialog(
            isPresented: $showExitDialog,
            onExit: {
                showExitDialog = false
                path.append("study")
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
        chord: "Am"
    )
}
