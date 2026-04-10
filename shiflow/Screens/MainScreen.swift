//
//  MainPageView.swift
//  shiflow
//
//  Created by Jose Putra Perdana Taneo on 09/04/26.
//

import SwiftUI

struct MainScreen: View {
    @Environment(MetronomeManager.self) private var metronome
        
    @State private var leftChord: Chord? = nil
    @State private var rightChord: Chord? = nil
        
    @State private var showingTempoSettings: Bool = false
    @State private var showingExercise: Bool = false
    
    let allChords = [aMinor, cMajor, dMajor, fMajor, eMinor, gMajor]
    
    func checkDisabled(for chord: Chord) -> Bool {
        if rightChord != nil && leftChord != nil {
            return true // tombol mati
        }
        
        if let left = leftChord {
            return !left.chordPairs.contains(chord.id)
        }
        
        if let right = rightChord {
            
            return !right.chordPairs.contains(chord.id)
        }
        
        return false // tombol aktif
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
                    Button("", systemImage: "trash"){
                        leftChord = nil
                    }
                    .offset(y: -90)
                    .foregroundStyle(.primaryDarkBrown)
                    .opacity(leftChord == nil ? 0 : 1)
                    
                    RoundedRectangle(cornerSize: CGSize(width: 30, height: 30), style: .circular)
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
                        Button("",systemImage: "metronome.fill") {
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
                    

                    RoundedRectangle(cornerSize: CGSize(width: 30, height: 30), style: .circular)
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
                    
                    Button("", systemImage: "trash"){
                        rightChord = nil
                    }
                    .offset(y: -90)
                    .foregroundStyle(.primaryDarkBrown)
                    .opacity(rightChord == nil ? 0 : 1)
                }
                .padding(.bottom, 16)
                
                HStack {
                    ForEach(allChords, id: \.id) { chord in
                        ChordButton(chordTitle: chord, isDisabled: checkDisabled(for: chord)) {
                            if leftChord == nil {
                                leftChord = chord
                            } else if rightChord == nil {
                                rightChord = chord
                            }
                        }
                    }
                }
                
                HStack {
                    Button("", systemImage: "books.vertical.circle.fill") {
                        // ke screen belajar chord
                    }
                    .font(.title)
                    .foregroundStyle(.primaryDarkBrown)
                    
                    Spacer()
                    
                    PrimaryButton(isDisabled: leftChord == nil || rightChord == nil){
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
                    ExerciseContainerView(chordA: left, chordB: right)
                    .environment(metronome)
                }
        }
    }
}

#Preview {
    MainScreen()
        .environment(MetronomeManager())
}
