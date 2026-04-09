//
//  PracticeScreenLayout.swift
//  shiflow
//
//  Created by Mohammad Rizaldy Ramadhan on 09/04/26.
//

import SwiftUI

enum PracticeTab: String, CaseIterable {
    case pushUp = "Push Up"
    case moonWalk = "Moon Walk"
    case rapidFire = "Rapid Fire"
}

struct PracticeScreenLayout<Content: View>: View {
    let activeTab: PracticeTab
    @ViewBuilder let content: () -> Content

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                // Tab bar
                HStack(spacing: 20) {
                    ForEach(PracticeTab.allCases, id: \.self) { tab in
                        Button(tab.rawValue) { }
                            .foregroundStyle(tab == activeTab ? .primaryDarkBrown : .primaryLightBrown)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: 50)

                // Screen-specific content
                content()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            // Dismiss button (top-left)
            VStack {
                HStack {
                    DissmissButton().padding(25)
                    Spacer()
                }
                Spacer()
            }
            .ignoresSafeArea()

            // Next button (bottom-right)
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    NextButton().padding(25)
                }
            }
            .ignoresSafeArea()
        }
    }
}
