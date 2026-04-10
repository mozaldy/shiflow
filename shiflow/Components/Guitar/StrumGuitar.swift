//
//  StrumGuitar.swift
//  shiflow
//
//  Created by Nicole Clarence on 07/04/26.
//

import SwiftUI

struct StrumGuitar: View {
    var chord: Chord
    var isActive: Bool
    var strumTrigger: Int

    var isDownStrum: Bool = true

    var body: some View {
        VStack(spacing: 0) {
            ForEach(Array(GuitarString.allCases.enumerated()), id: \.element) {
                index,
                guitarString in
                GuitarStringRow(
                    guitarString: guitarString,
                    isGuitarStringStrummed: chord.isStringStrummed(
                        for: guitarString
                    ),
                    index: index,
                    strumTrigger: strumTrigger,
                    isDownStrum: isDownStrum
                )
            }
        }
        .background(
            Rectangle().fill(.primaryLightBrown).overlay(
                Circle().fill(.primaryDarkBrown)
            )
        )
        .guitarContainer(isActive: isActive)
    }
}

struct GuitarStringRow: View {
    @Environment(\.guitarSize) var size

    var guitarString: GuitarString
    var isGuitarStringStrummed: Bool
    var index: Int
    var strumTrigger: Int
    var isDownStrum: Bool

    @State private var isFlashingGreen: Bool = false

    var body: some View {
        GuitarStringLine(
            guitarString: guitarString,
            isStrummed: isGuitarStringStrummed,
            highlightColor: isFlashingGreen ? .green : nil
        )
        .frame(height: size.rowHeight)
        .onChange(of: strumTrigger) {
            guard isGuitarStringStrummed else { return }
            triggerFlash()
        }
    }

    private func triggerFlash() {
        Task {
            let maxIndex = GuitarString.allCases.count - 1
            let delayMultiplier = isDownStrum ? index : (maxIndex - index)
            let staggerDuration: Double = 0.05
            let totalDelay = Double(delayMultiplier) * staggerDuration

            try? await Task.sleep(
                nanoseconds: UInt64(totalDelay * 1_000_000_000)
            )

            withAnimation(.interactiveSpring) {
                isFlashingGreen = true
            }

            try? await Task.sleep(nanoseconds: 150_000_000)

            withAnimation(.easeInOut(duration: 0.2)) {
                isFlashingGreen = false
            }
        }
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State private var strumTrigger = 0

        var body: some View {
            VStack(spacing: 50) {
                StrumGuitar(
                    chord: cMajor,
                    isActive: true,
                    strumTrigger: strumTrigger
                )

                Button(action: {
                    strumTrigger += 1
                }) {
                    Text("Strum!")
                        .font(.title2)
                        .bold()
                        .padding()
                        .frame(width: 200)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
            }
        }
    }

    return PreviewWrapper()
}
