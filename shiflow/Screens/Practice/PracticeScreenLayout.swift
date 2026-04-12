//
//  PracticeScreenLayout.swift
//  shiflow
//
//  Created by Mohammad Rizaldy Ramadhan on 09/04/26.
//

import SwiftUI

struct PracticeScreenLayout<Content: View>: View {
    let activeTab: PracticeTab
    var onNext: () -> Void = {}
    var onDismiss: () -> Void = {}
    @ViewBuilder let content: () -> Content

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                PracticeTabHeader(activeTab: activeTab)

                RepCounter()

                content()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            VStack {
                HStack {
                    DissmissButton(action: onDismiss)
                    .padding(25)
                    Spacer()
                }
                Spacer()
            }
            .ignoresSafeArea()

            VStack {
                Spacer()
                HStack {
                    Spacer()
                    NextButton(action: onNext).padding(25)
                }
            }
            .ignoresSafeArea()
        }
    }
}

#Preview{
    PracticeScreenLayout (activeTab: .pushUp) {
        Text("Hello")
    }
    .environment(MetronomeManager())
}
