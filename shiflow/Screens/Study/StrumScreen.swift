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
    @State private var showExitDialog = false

    var body: some View {
        VStack {
            VStack(spacing: 10) {

                Text(title)
                    .font(.largeTitle)
                    .bold()

                Text("Detail content for \(title)")
                    .foregroundStyle(.secondary)
            }
            .padding(.top)

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
        title: "How to Strum"
    )
}
