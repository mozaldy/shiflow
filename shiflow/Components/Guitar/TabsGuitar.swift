//
//  TabsGuitar.swift
//  shiflow
//
//  Created by Nicole Clarence on 07/04/26.
//

import SwiftUI

struct TabsGuitar: View {
    @Environment(\.guitarSize) var size

    var chord: Chord
    var isActive: Bool
    var fretCount: Int = 4

    var body: some View {
        VStack(spacing: 0) {
            ForEach(GuitarString.allCases, id: \.self) { guitarString in
                HStack(spacing: 0) {
                    Text("\(guitarString.rawValue)")
                        .foregroundStyle(.white)
                        .frame(width: 25, height: size.rowHeight)
                        .background(.primaryDarkBrown)

                    ForEach(0..<fretCount, id: \.self) { fret in
                        FretCell(
                            fingerNumber: chord.getFingerNumber(
                                string: guitarString,
                                fret: fret + 1
                            ),
                            guitarString: guitarString,
                            isGuitarStringStrummed: chord.isStringStrummed(
                                for: guitarString
                            )
                        )
                    }
                }
            }
        }
        .background(.primaryLightBrown)
        .guitarContainer(isActive: isActive)
    }
}

struct FretCell: View {
    @Environment(\.guitarSize) var size

    var fingerNumber: Int?
    var guitarString: GuitarString
    var isGuitarStringStrummed: Bool

    var body: some View {
        ZStack {
            // Fret borders
            Rectangle()
                .fill(.primaryDarkBrown)
                .frame(width: 2)
                .frame(maxWidth: .infinity, alignment: .trailing)

            Rectangle()
                .fill(.primaryDarkBrown)
                .frame(width: 2)
                .frame(maxWidth: .infinity, alignment: .leading)

            // String line
            GuitarStringLine(
                guitarString: guitarString,
                isStrummed: isGuitarStringStrummed
            )

            // Finger dot
            if let fingerNumber = fingerNumber {
                ZStack {
                    Circle()
                        .fill(.black)
                        .frame(width: size.dotSize, height: size.dotSize)

                    Text("\(fingerNumber)")
                        .foregroundColor(.white)
                        .font(.system(size: size.fontSize, weight: .bold))
                }
            }
        }
        .frame(height: size.rowHeight)
    }
}

#Preview {
    HStack {
        TabsGuitar(chord: aMinor, isActive: true)
        TabsGuitar(chord: dMajor, isActive: false)
    }
}
