//
//  ExitDialog.swift
//  shiflow
//
//  Created by Devon on 07/04/26.
//

import SwiftUI

struct ExitDialogModifier: ViewModifier {
    @Binding var isPresented: Bool
    var onExit: () -> Void
    var onCancel: () -> Void

    func body(content: Content) -> some View {
        ZStack {
            content

            if isPresented {
                // low opacity background
                Color.black.opacity(0.3)
                    .ignoresSafeArea()
                    .transition(.opacity)

                ExitDialog(
                    onExit: onExit,
                    onCancel: onCancel
                )
                .padding(.horizontal, 40)
                .transition(.scale(scale: 0.8).combined(with: .opacity))
            }
        }
    }
}

extension View {
    func exitDialog(
        isPresented: Binding<Bool>,
        onExit: @escaping () -> Void,
        onCancel: @escaping () -> Void
    ) -> some View {
        self.modifier(
            ExitDialogModifier(
                isPresented: isPresented,
                onExit: onExit,
                onCancel: onCancel
            )
        )
    }
}

struct ExitDialog: View {
    var title: String = "Are you sure you want to exit?"
    var message: String =
        "Exiting right now will mean you'll lose your progress."
    let onExit: () -> Void
    let onCancel: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Text
            Text(title)
                .font(.headline)

            Text(message)
                .font(.subheadline)
                .multilineTextAlignment(.leading)
                .padding(.bottom, 12)

            // Buttons
            HStack(spacing: 8) {
                Button(action: onExit) {
                    Text("Exit")
                        .bold()
                        .frame(maxWidth: 150)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 12)
                        .foregroundStyle(.black)
                        .background(Color.gray.opacity(0.2))
                        .clipShape(Capsule())
                }
                Button(action: onCancel) {
                    Text("Cancel")
                        .bold()
                        .frame(maxWidth: 150)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 12)
                        .foregroundStyle(.white)
                        .background(Color.primaryDarkBrown)
                        .clipShape(Capsule())
                }
            }
        }
        .padding(20)
        .background(.regularMaterial)
        .frame(maxWidth: 300)
        .clipShape(
            RoundedRectangle(
                cornerSize: CGSize(width: 30, height: 30),
                style: .continuous
            )
        )
        .shadow(color: .black.opacity(0.15), radius: 10, x: 0, y: 5)
    }
}

#Preview {
    ExitDialog(onExit: {}, onCancel: {})
}
