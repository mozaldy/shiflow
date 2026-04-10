//
//  ChordCard.swift
//  shiflow
//
//  Created by Theressa Natasha Thebez on 08/04/26.
//

import SwiftUI

struct ChordCard: View {
    var imageName: String
    var title: String
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                VStack(alignment: .center, spacing: 8) {
                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 150)
                        .cornerRadius(8)

                    Text(title)
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                }
            }

        }
    }
}
