//
//  GuitarContainerModifier.swift
//  shiflow
//
//  Created by Mohammad Rizaldy Ramadhan on 09/04/26.
//

import SwiftUI

struct GuitarContainerModifier: ViewModifier {
    var isActive: Bool

    func body(content: Content) -> some View {
        content
            .overlay {
                Rectangle().opacity(isActive ? 0.0 : 0.6)
            }
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .frame(width: 300)
    }
}

extension View {
    func guitarContainer(isActive: Bool) -> some View {
        modifier(GuitarContainerModifier(isActive: isActive))
    }
}
