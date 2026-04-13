//
//  StrumPage.swift
//  shiflow
//
//  Created by Theressa Natasha Thebez on 08/04/26.
//

import Foundation
import SwiftUI

struct StrumScreen: View {
    @Environment(MetronomeManager.self) private var metronome

    @Binding var path: NavigationPath

    var title: String
    var chord: Chord

    @State private var showExitDialog = false
    @State private var strumTrigger: Int = 0


    var body: some View {
        VStack {
            Text(title)
                .font(.largeTitle)
                .bold()
                .padding(.vertical, 15)

            HStack(spacing: 60) {
                Image("\(chord.id.lowercased())_chord").resizable()
                    .frame(width: 300, height: 200)

                Divider()
                    .background(Color.primaryDarkBrown)
                    .shadow(color: .brown.opacity(1), radius: 8)

                StrumGuitar(
                    chord: chord,
                    isActive: true,
                    strumTrigger: strumTrigger
                )

            }
            .onAppear {
                metronome.startMetronome()
            }
            .onDisappear {
                metronome.stopMetronome()
            }
            .onChange(of: metronome.beatCount) {
                guard metronome.isFirstBeatOfBar else { return }
                metronome.playChordSound(chord: chord)
                strumTrigger += 1
            }
            
            Spacer()

            HStack {
                Spacer()
                Button {
                    path = NavigationPath()
                } label: {
                    Text("Done")
                        .font(.headline)
                        .padding(.horizontal, 30)
                        .padding(.vertical, 12)
                        .background(Color.brown)
                        .foregroundStyle(.white)
                        .clipShape(Capsule())
                }
            }
        }
        .padding()
        .navigationBarBackButtonHidden(true)

    }
}

#Preview {
    StrumScreen(
        path: .constant(
            NavigationPath()
        ),
        title: "How to Strum",
        chord: aMinor
    )
    .environment(MetronomeManager())
}
