//
//  StrumGuitar.swift
//  shiflow
//
//  Created by Nicole Clarence on 07/04/26.
//

import SwiftUI

struct StrumGuitar: View {
    var chord: Chord
    var isActive: Bool
    
    
    
    
    var body: some View {
        
        Text(chord.name).padding()
            VStack(spacing: 0){ // container string
                
                
                ForEach(GuitarString.allCases, id: \.self) { guitarString in
                    let isGuitarStringStrummed = chord.isStringStrummed(for: guitarString)
                    GuitarStringRow(guitarString: .E6, isGuitarStringStrummed: isGuitarStringStrummed)
                }
                
                
            }
            .overlay {
                Rectangle().opacity( isActive ? 0.0 : 0.6)
            }.background(Rectangle().fill(.primaryLightBrown).overlay(Circle().fill(.primaryDarkBrown)))
            .clipShape(RoundedRectangle(cornerRadius: 12)).frame(width: 300)
            
    }
}

struct GuitarStringRow: View {
    var guitarString: GuitarString
    var isGuitarStringStrummed: Bool
    
    var stringThickness: Double { switch (guitarString) {
    case GuitarString.E6:
        return 6.0
    case GuitarString.A:
        return 5.0
    case GuitarString.D:
        return 4.0
    case GuitarString.G:
        return 3.0
    case GuitarString.B:
        return 2.0
    case GuitarString.e1:
        return 1.0
    }
        
    }
    
    var body: some View {
        Rectangle()
            .fill(isGuitarStringStrummed ? Color.black : Color.red)
            .frame(height: stringThickness).frame(height: 40)
        
    }
}



#Preview {
    
    HStack{
        StrumGuitar(chord: eMinor, isActive: true)
    }
    
}
