//
//  PushUpPage.swift
//  shiflow
//
//  Created by Theressa Natasha Thebez on 08/04/26.
//

import Foundation
import SwiftUI

struct PushUpScreen: View {
    @Binding var path: NavigationPath
    var title: String
    @State private var showExitDialog = false

    var body: some View {
        VStack {
            Text(title)
                .font(.largeTitle)
                .bold()
                .padding(.vertical)

            HStack(spacing: 80) {
                Image("am_chord")
                    .resizable()
                    .frame(width: 300, height: 200)

                Image("am_strum")
                    .resizable()
                    .frame(width: 300, height: 200)
            }
            
            Spacer()

            HStack {
                Spacer()
                Button {
                    path.append("strum")
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
    PushUpScreen(
        path: .constant(NavigationPath()),
        title: "Finger Push Up"
    )
}
