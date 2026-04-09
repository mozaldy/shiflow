//
//  MainScreen.swift
//  shiflow
//
//  Created by Theressa Natasha Thebez on 09/04/26.
//

import Foundation
import SwiftUI

struct MainScreen: View {
    @State private var path = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {
            VStack(spacing: 40) {

                Spacer()

                VStack(spacing: 12) {
                    Text("Shiflow")
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    Text("Learn Guitar Chords Easily 🎸")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                Spacer()

                NavigationLink {
                    MainStudyScreen(path: $path)
                } label: {
                    HStack {
                        Image(systemName: "play.fill")
                        Text("Start Learning")
                    }
                    .font(.headline)
                    .padding(.horizontal, 40)
                    .padding(.vertical, 14)
                    .background(Color.brown)
                    .foregroundStyle(.white)
                    .clipShape(Capsule())
                }

                Spacer()
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
}
