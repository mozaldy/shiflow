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
