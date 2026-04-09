//
//  FingerMoonWalkScreen.swift
//  shiflow
//
//  Created by Mohammad Rizaldy Ramadhan on 09/04/26.
//

import SwiftUI
struct FingerMoonWalkScreen: View {
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            
            VStack(spacing: 0) {
                HStack(spacing: 20) {
                    Button("Push Up") { }
                        .foregroundStyle(.primaryLightBrown)
                    Button("Moon Walk") { }
                        .foregroundStyle(.primaryDarkBrown)
                    Button("Rapid Fire") { }
                        .foregroundStyle(.primaryLightBrown)
                }
                .frame(maxWidth: .infinity, maxHeight: 50)

                HStack {
                    TabsGuitar(chord: aMinor, isActive: true)
                    Spacer()
                    TabsGuitar(chord: dMajor, isActive: false)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
            
                        VStack {
                            HStack {
                                DissmissButton().padding(25)
                                Spacer()
                            }
                            Spacer()
                        }.ignoresSafeArea()
                        
                        VStack {
                            Spacer()
                            HStack {
                                Spacer()
                                NextButton().padding(25)
                            }
                        }.ignoresSafeArea()
        }
    }
}

#Preview {
    FingerMoonWalkScreen()
}
