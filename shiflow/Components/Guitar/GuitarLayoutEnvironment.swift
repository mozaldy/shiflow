//
//  GuitarLayoutEnvironment.swift
//  shiflow
//
//  Created by Theressa Natasha Thebez on 10/04/26.
//

import SwiftUI

enum GuitarComponentSize {
    case regular, small

    var rowHeight: CGFloat {
        self == .regular ? 40 : 24
    }

    var dotSize: CGFloat {
        self == .regular ? 30 : 18
    }

    var fontSize: CGFloat {
        self == .regular ? 18 : 12
    }
}

private struct GuitarSizeKey: EnvironmentKey {
    static let defaultValue: GuitarComponentSize = .regular
}

extension EnvironmentValues {
    var guitarSize: GuitarComponentSize {
        get { self[GuitarSizeKey.self] }
        set { self[GuitarSizeKey.self] = newValue }
    }
}
