//
//  FingerMoonWalkScreen.swift
//  shiflow
//
//  Created by Mohammad Rizaldy Ramadhan on 09/04/26.
//

import SwiftUI

struct FingerMoonWalkScreen: View {
    var body: some View {
        PracticeScreenLayout(activeTab: .moonWalk) {
            HStack {
                TabsGuitar(chord: aMinor, isActive: true)
                Spacer()
                TabsGuitar(chord: dMajor, isActive: false)
            }
        }
    }
}

#Preview {
    FingerMoonWalkScreen()
}
