//
//  TabsGuitar.swift
//  shiflow
//
//  Created by Nicole Clarence on 07/04/26.
//

import SwiftUI

struct TabsGuitar: View {
    var chord: Chord
    var stringsCount: Int = 6
    var fretCount: Int = 4
    
    
    var body: some View {
        
        Text(chord.name).padding()
        VStack(spacing: 0){ // container string
            
            ForEach(GuitarString.allCases, id: \.self) { guitarString in
                HStack(spacing: 0) { // container fret
                    Text("\(guitarString.rawValue)").foregroundStyle(.white).frame(width: 25, height: 40).background(Color.black)
                    
                    ForEach(0..<fretCount, id: \.self) { fret in
                        let fingerNumber = chord.getFingerNumber(string: guitarString, fret: fret + 1)
                        FretCell(fingerNumber: fingerNumber, guitarString: guitarString)
                    }
                }
            }
        }
            .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

struct FretCell: View {
    var fingerNumber: Int?
    var guitarString: GuitarString
    
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
                .fill(Color.black)
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
        .frame(width: 60, height: 40)
    }
}


#Preview {
    let cm = Chord(name: "C Major", placements: [
        FingerPlacement(string: .A,  fretNumber: 3, fingerNumber: 3),  // ring on 5th string, 3rd fret
        FingerPlacement(string: .D,  fretNumber: 2, fingerNumber: 2),  // middle on 4th string, 2nd fret
        FingerPlacement(string: .G,  fretNumber: 0, fingerNumber: 0),  // open
        FingerPlacement(string: .B,  fretNumber: 1, fingerNumber: 1),  // index on 2nd string, 1st fret
        FingerPlacement(string: .e1, fretNumber: 0, fingerNumber: 0),  // open
        // E6 string is muted (not played)
    ])
    HStack{
        TabsGuitar(chord: cm)
        TabsGuitar(chord: cm)
    }
}
