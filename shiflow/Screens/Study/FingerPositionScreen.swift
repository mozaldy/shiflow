//
//  FingerPositionPage.swift
//  shiflow
//
//  Created by Theressa Natasha Thebez on 08/04/26.
//

import SwiftUI

struct FingerPositionScreen: View {
    @Binding var path: NavigationPath

    var title: String
    var chord: String

    @State private var showExitDialog = false
    @State private var showFinger = false

    var body: some View {
        VStack {
            Text(title)
                .font(.largeTitle)
                .bold()
                .padding(.vertical)

            HStack(spacing: 60) {
                ZStack {
                    Image("\(chord.lowercased())_chord").resizable()
                        .frame(width: 300, height: 200)
                        .opacity(showFinger ? 0 : 1)

                    Image("\(chord.lowercased())_exercise").resizable()
                        .frame(width: 300, height: 200)
                        .opacity(showFinger ? 1 : 0)
                }
                .onAppear {
                    Timer.scheduledTimer(withTimeInterval: 2, repeats: true) {
                        _ in
                        withAnimation {
                            showFinger.toggle()
                        }
                    }
                }

                Image("HandCount")
                    .resizable()
                    .frame(width: 200, height: 200)
            }
            .animation(.easeInOut(duration: 0.5), value: showFinger)

            Spacer()

            HStack {
                Spacer()
                Button {
                    path.append("pushup-\(chord)")
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

    func chordImage() -> String {
        return title.lowercased()
    }

    func exerciseImage() -> String {
        return "\(title.lowercased())_exercise"
    }
}

#Preview {
    FingerPositionScreen(
        path: .constant(NavigationPath()),
        title: "Finger Position",
        chord: "Am"
    )
}
