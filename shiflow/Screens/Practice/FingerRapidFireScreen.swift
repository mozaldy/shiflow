//
//  FingerRapidFireScreen.swift
//  shiflow
//
//  Created by Mohammad Rizaldy Ramadhan on 09/04/26.
//

import SwiftUI

struct FingerRapidFireScreen: View {
    var body: some View {
        PracticeScreenLayout(activeTab: .rapidFire) {
            HStack {
                VStack {
                    TabsGuitar(chord: aMinor, isActive: true)
                        .environment(\.guitarSize, .small)
                    StrumGuitar(chord: aMinor, isActive: true, strumTrigger: 0)
                        .environment(\.guitarSize, .small)
                }
                VStack {
                    TabsGuitar(chord: aMinor, isActive: true)
                        .environment(\.guitarSize, .small)
                    StrumGuitar(chord: aMinor, isActive: true, strumTrigger: 0)
                        .environment(\.guitarSize, .small)
                }
            }
        }
    }
}

#Preview {
    FingerRapidFireScreen()
}
