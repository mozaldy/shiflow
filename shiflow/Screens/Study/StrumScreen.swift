//
//  StrumPage.swift
//  shiflow
//
//  Created by Theressa Natasha Thebez on 08/04/26.
//

import Foundation
import SwiftUI

struct StrumScreen: View {
    @Binding var path: NavigationPath
    var title: String
    var chord: String
    @State private var showExitDialog = false

    @StateObject private var beat = BeatTimer(bpm: 80)
    @State private var strumTrigger: Int = 0
    let chords = aMinor
    private let beatsPerBar = 4

    private var beatInBar: Int {
        ((beat.beatCount - 1) % beatsPerBar) + 1
    }

    private var isFirstBeatOfBar: Bool {
        beatInBar == 1
    }

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
                    strumTrigger: strumTrigger,
                    isDownStrum: true
                )

            }

            Spacer()

            HStack {
                Spacer()
                Button {
                    path.append("study")
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
            beat.start()
        }
        .onDisappear {
            beat.stop()
        }

        .onChange(of: beat.beatCount) {
            guard isFirstBeatOfBar else { return }
            strumTrigger += 1
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
    StrumScreen(
        path: .constant(
            NavigationPath()
        ),
        title: "How to Strum", chord: "am_chord"
    )
}
