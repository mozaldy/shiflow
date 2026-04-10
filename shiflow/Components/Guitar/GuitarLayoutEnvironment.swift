//
//  GuitarLayoutEnvironment.swift
//  shiflow
//
//  Created by Mohammad Rizaldy Ramadhan on 09/04/26.
//

import SwiftUI

enum GuitarComponentSize {
    case regular, small
    
    var rowHeight: CGFloat {
        self == .regular ? 40 : 20
    }
    
    var dotSize: CGFloat {
        self == .regular ? 30 : 14
    }
    
    var fontSize: CGFloat {
        self == .regular ? 18 : 10
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
