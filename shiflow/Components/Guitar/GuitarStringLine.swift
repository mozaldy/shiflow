//
//  GuitarStringLine.swift
//  shiflow
//
//  Created by Theressa Natasha Thebez on 10/04/26.
//

import SwiftUI

struct GuitarStringLine: View {
    var guitarString: GuitarString
    var isStrummed: Bool
    var highlightColor: Color? = nil

    var body: some View {
        Rectangle()
            .fill(highlightColor ?? (isStrummed ? Color.black : Color.red))
            .frame(height: guitarString.thickness)
    }
}
