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
    @State private var showExitDialog = false

    var body: some View {
        VStack {
            VStack(spacing: 8) {

                Text(title)
                    .font(.title)
                    .bold()

                Text("Detail content for \(title)")
                    .foregroundStyle(.secondary)
            }
            .padding(.vertical)

            HStack(spacing: 80) {
                Image("am_chord")
                    .resizable()
                    .scaledToFit()

                Image("HandCount")
                    .resizable()
                    .scaledToFit()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            Spacer()

            HStack {
                Spacer()
                Button {
                    path.append("pushup")
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
        .padding()
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
}

#Preview {
    FingerPositionScreen(
        path: .constant(NavigationPath()),
        title: "Finger Position"
    )
}
