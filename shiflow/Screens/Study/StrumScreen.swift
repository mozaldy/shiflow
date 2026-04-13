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
    var chord: String
    @State private var showExitDialog = false

    @State private var strumTrigger: Int = 0
    let chords = aMinor

    var body: some View {
        VStack {

            Text(title)
                .font(.largeTitle)
                .bold()
                .padding(.vertical)

            HStack(spacing: 60) {
                Image("\(chord.lowercased())")                    .resizable()
                    .frame(width: 300, height: 200)

                Divider()
                    .background(Color.primaryDarkBrown)
                    .shadow(color: .brown.opacity(1), radius: 8)

                StrumGuitar(
                    chord: chords,
                    isActive: true,
                    strumTrigger: strumTrigger
                )

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
        .onAppear {
//            beat.start()
            metronome.startMetronome()
        }
        .onDisappear {
//            beat.stop()
            metronome.stopMetronome()
        }

        .onChange(of: metronome.beatCount) {
            guard metronome.isFirstBeatOfBar else { return }
            strumTrigger += 1
        }
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
    StrumScreen(
        path: .constant(
            NavigationPath()
        ),
        title: "How to Strum", chord: "am_chord"
    )
    .environment(MetronomeManager())
}
