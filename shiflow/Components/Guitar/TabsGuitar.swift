//
//  TabsGuitar.swift
//  shiflow
//
//  Created by Nicole Clarence on 07/04/26.
//

import SwiftUI

struct TabsGuitar: View {
    var chord: Chord
    var isActive: Bool
    var fretCount: Int = 4
    
    
    var body: some View {
        
        Text(chord.name).padding()
        VStack(spacing: 0){ // container string
            
            ForEach(GuitarString.allCases, id: \.self) { guitarString in
                HStack(spacing: 0) { // container fret
                    Text("\(guitarString.rawValue)").foregroundStyle(.white).frame(width: 25, height: 40).background(Color.black)
                    
                    ForEach(0..<fretCount, id: \.self) { fret in
                        let fingerNumber = chord.getFingerNumber(string: guitarString, fret: fret + 1)
                        let isGuitarStringStrummed = chord.isStringStrummed(for: guitarString)
                        FretCell(fingerNumber: fingerNumber, guitarString: guitarString, isGuitarStringStrummed: isGuitarStringStrummed)
                    }
                }
            }
            
        }
        .overlay {
            Rectangle().opacity( isActive ? 0.0 : 0.6)
        }
        .clipShape(RoundedRectangle(cornerRadius: 12)).frame(width: 300)
        
    }
}

struct FretCell: View {
    var fingerNumber: Int?
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
        ZStack {
            Color.blue.opacity(0.2)
            
            
            Rectangle()
                .fill(isGuitarStringStrummed ? Color.black : Color.red)
                .frame(height: stringThickness)
            
            
            if let fingerNumber = fingerNumber {
                ZStack {
                    Circle()
                        .fill(.black)
                        .frame(width: 35, height: 35)
                    
                    Text("\(fingerNumber)")
                        .foregroundColor(.white)
                        .font(.system(size: 20, weight: .bold))
                }
            }
        }
        .frame(height: 40)
    }
}


#Preview {
    
    HStack{
        TabsGuitar(chord: aMinor, isActive: true)
        TabsGuitar(chord: dMajor, isActive: false)
    }
    
}
