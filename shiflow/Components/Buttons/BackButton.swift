//
//  BackButton.swift
//  shiflow
//
//  Created by Nicole Clarence on 08/04/26.
//

import SwiftUI
import SwiftUI
struct BackButton: View {

    var body: some View {
        Image(systemName: "chevron.backward")
            .padding(10)
            .background(Color.primaryDarkBrown)
            .foregroundStyle(.white)
            .clipShape(Circle())
            .bold()
            .shadow(radius: 3)
    }
}

#Preview {
    BackButton()
}
