//
//  MainScreen.swift
//  shiflow
//
//  Created by Theressa Natasha Thebez on 09/04/26.
//

import Foundation
import SwiftUI

struct MainScreen: View {
    @Environment(MetronomeManager.self) private var metronome

    @State private var path = NavigationPath()
    @State private var leftChord: Chord? = nil
    @State private var rightChord: Chord? = nil

    @State private var showingTempoSettings: Bool = false

    let allChords = [aMinor, cMajor, dMajor, fMajor, eMinor, gMajor]

    func checkDisabled(for chord: Chord) -> Bool {
        if rightChord != nil && leftChord != nil {
            return true  // tombol mati
        }

        if let left = leftChord {
            return !left.chordPairs.contains(chord.id)
        }

        if let right = rightChord {

            return !right.chordPairs.contains(chord.id)
        }

        return false  // tombol aktif
    }

    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                // Kalau mau taruh background
                // Color.white.ignoresSafeArea()

                VStack(spacing: 0) {
                    Text("Shiflow")
                        .font(.title)
                        .bold()
                        .padding(.top, 30)
                        .padding(.bottom, 16)

                    HStack(alignment: .center, spacing: 20) {
                        Button("", systemImage: "trash") {
                            leftChord = nil
                        }
                        .offset(y: -90)
                        .foregroundStyle(.primaryDarkBrown)
                        .opacity(leftChord == nil ? 0 : 1)

                        RoundedRectangle(
                            cornerSize: CGSize(width: 30, height: 30),
                            style: .circular
                        )
                        .frame(maxWidth: 250, maxHeight: 225)
                        .foregroundStyle(.primaryLightBrown)
                        .overlay {
                            if let chord = leftChord {
                                Text(chord.id)
                                    .font(.largeTitle)
                                    .fontWeight(.heavy)
                                    .foregroundStyle(.primaryDarkBrown)
                            } else {
                                Text("Select a chord")
                                    .font(.subheadline)
                                    .fontWeight(.regular)
                                    .foregroundStyle(.gray)
                            }
                        }

                        VStack(alignment: .center) {
                            Button("", systemImage: "metronome.fill") {
                                showingTempoSettings = true
                            }
                            .font(.title)
                            .buttonStyle(.glassProminent)
                            .disabled(leftChord == nil || rightChord == nil)

                            Text("\(Int(metronome.tempo))")
                                .font(.title)
                                .fontWeight(.semibold)
                            Text("BPM")
                                .font(.caption)
                        }

                        RoundedRectangle(
                            cornerSize: CGSize(width: 30, height: 30),
                            style: .circular
                        )
                        .frame(maxWidth: 250, maxHeight: 225)
                        .foregroundStyle(.primaryLightBrown)
                        .overlay {
                            if let chord = rightChord {
                                Text(chord.id)
                                    .font(.largeTitle)
                                    .fontWeight(.heavy)
                                    .foregroundStyle(.primaryDarkBrown)
                            } else {
                                Text("Select a chord")
                                    .font(.subheadline)
                                    .fontWeight(.regular)
                                    .foregroundStyle(.gray)
                            }
                        }

                        Button("", systemImage: "trash") {
                            rightChord = nil
                        }
                        .offset(y: -90)
                        .foregroundStyle(.primaryDarkBrown)
                        .opacity(rightChord == nil ? 0 : 1)
                    }
                    .padding(.bottom, 16)

                    HStack {
                        ForEach(allChords, id: \.id) { chord in
                            ChordButton(
                                chordTitle: chord,
                                isDisabled: checkDisabled(for: chord)
                            ) {
                                if leftChord == nil {
                                    leftChord = chord
                                } else if rightChord == nil {
                                    rightChord = chord
                                }
                            }
                        }
                    }

                    HStack {
                        Button {
                            path.append("study")
                        } label: {
                            HStack {
                                Image(
                                    systemName: "books.vertical.circle.fill"
                                )
                            }
                            .font(.title)
                            .foregroundStyle(.primaryDarkBrown)
                        }

                        Spacer()

                        PrimaryButton(
                            isDisabled: leftChord == nil || rightChord == nil
                        )

                    }
                    .offset(y: -16)

                }
                .blur(radius: showingTempoSettings ? 2 : 0)

                // Tempo Setup
                if showingTempoSettings {
                    Color.black.opacity(0.6)
                        .ignoresSafeArea()

                    TempoSettingsView(isShowing: $showingTempoSettings)
                        .frame(width: 260, height: 350)
                        .padding(.vertical, 0)
                        .padding(.horizontal, 30)
                        .background(.thinMaterial)
                        .cornerRadius(30)
                        .shadow(radius: 20)
                }
            }
            .navigationDestination(for: String.self) { value in
                if value == "study" {
                    MainStudyScreen(path: $path)
                } else if value == "finger" {
                    FingerPositionScreen(path: $path, title: "Finger Position")
                } else if value == "pushup" {
                    PushUpScreen(path: $path, title: "Exercise")
                } else if value == "strum" {
                    StrumScreen(path: $path, title: "Strum")
                }
            }
        }
    }
}

#Preview {
    MainScreen()
        .environment(MetronomeManager())
}
