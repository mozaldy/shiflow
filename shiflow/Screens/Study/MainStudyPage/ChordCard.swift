//
//  ChordCard.swift
//  shiflow
//
//  Created by Theressa Natasha Thebez on 08/04/26.
//

import SwiftUI

struct ChordCard <Destination: View> : View {
    var imageName: String
    var title: String
    var destination: Destination
    
    var body: some View {
        NavigationLink {
            destination
        } label: {
            VStack(alignment: .center, spacing: 8) {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .background(Color.primaryDarkBrown)
                    .cornerRadius(8)
                
                Text(title)
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
            }
        }
        
    }
}


