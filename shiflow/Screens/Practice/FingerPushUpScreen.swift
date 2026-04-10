//
//  FingerPushUpScreen.swift
//  shiflow
//
//  Created by Mohammad Rizaldy Ramadhan on 09/04/26.
//

import SwiftUI

struct FingerPushUpScreen: View {
    @Environment(MetronomeManager.self) private var metronome
    
    let chordA: Chord
    let chordB: Chord
    
    @State private var isCountingDown = true
    @State private var showingNextExercise: Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                Text("Exercise: \(chordA.name) - \(chordB.name)")
                Text("BPM: \(Int(metronome.tempo))")
                // Konten latihan lainnya nanti di sini
            }
            
        }
        
    }
}

#Preview {
    FingerPushUpScreen(chordA: aMajor, chordB: dMajor)
        .environment(MetronomeManager())
}
