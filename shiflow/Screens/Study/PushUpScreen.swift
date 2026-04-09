//
//  PushUpPage.swift
//  shiflow
//
//  Created by Theressa Natasha Thebez on 08/04/26.
//

//
//  MainStudyPage.swift
//  shiflow
//
//  Created by Theressa Natasha Thebez on 08/04/26.
//

import Foundation
import SwiftUI

struct PushUpPage: View {
    var title: String
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack(spacing: 20) {
            Text(title)
                .font(.largeTitle)
                .bold()
            
            Text("Detail content for \(title)")
                .foregroundStyle(.secondary)
        }
        .padding()
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                }
            }
        }
    }
}

#Preview {
    PushUpPage(title: "Finger Push Up")
}
