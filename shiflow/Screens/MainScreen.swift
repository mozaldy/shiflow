//
//  MainPageView.swift
//  shiflow
//
//  Created by Jose Putra Perdana Taneo on 09/04/26.
//

import SwiftUI

struct MainScreen: View {
    @Environment(MetronomeManager.self) private var metronome
    @Environment(\.dismiss) private var dismiss

    @State private var leftChord: Chord? = nil
    @State private var rightChord: Chord? = nil

    @State private var showingTempoSettings: Bool = false
    @State private var showingExercise: Bool = false
    @State private var showingStudyChord: Bool = false

    @State private var studyPath = NavigationPath()

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
        ZStack {
            // Kalau mau taruh background
            // Color.white.ignoresSafeArea()

            VStack(spacing: 0) {
                Text("Shiflow")
                    .font(.title)
                    .bold()
                    .padding(.top, 8)
                    .padding(.bottom, 16)
                
                HStack(alignment: .center ,spacing: 20){
                    MainScreenChordCard(selectedChord: $leftChord)
                    
                    VStack(alignment: .center) {
                        Button {
                            showingTempoSettings = true
                        } label: {
                            Image(systemName: "metronome.fill")
                        }
                        .font(.title)
                        .buttonStyle(.glassProminent)
                        .tint(.primaryDarkBrown)
                        .disabled(leftChord == nil || rightChord == nil)

                        Text("\(Int(metronome.tempo))")
                            .font(.title)
                            .fontWeight(.semibold)
                        Text("BPM")
                            .font(.caption)
                    }
                    

                    MainScreenChordCard(selectedChord: $rightChord)
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
                            metronome.playChordSound(chord: chord)
                        }
                    }
                }

                HStack {
                    Button("Study", systemImage: "books.vertical") { showingStudyChord = true
                    }
                    .font(.footnote)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(.white)
                    .foregroundStyle(.primaryDarkBrown)
                    .clipShape(Capsule())
                    .bold()
                    .overlay(
                                Capsule()
                                    .stroke(Color.primaryDarkBrown, lineWidth: 2)
                            )

                    
                    Spacer()

                    PrimaryButton(
                        isDisabled: leftChord == nil || rightChord == nil
                    ) {
                        showingExercise = true
                    }
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
        .fullScreenCover(isPresented: $showingExercise) {
            if let left = leftChord, let right = rightChord {
                ExerciseContainerView(
                    isPresented: $showingExercise,
                    chordA: left,
                    chordB: right
                )
                .environment(metronome)
            }
        }
        .fullScreenCover(isPresented: $showingStudyChord) {
            NavigationStack(path: $studyPath) {
                MainStudyScreen(path: $studyPath, selectedChord: aMinor)
                    .environment(metronome)
            }
        }
    }
}

#Preview {
    MainScreen()
        .environment(MetronomeManager())
}
