//
//  Chord.swift
//  shiflow
//
//  Created by Mohammad Rizaldy Ramadhan on 08/04/26.
//

import Foundation

enum GuitarString: String, CaseIterable, Hashable {
    case E6 = "E"   // 6th string (low E, thickest)
    case A  = "A"   // 5th string
    case D  = "D"   // 4th string
    case G  = "G"   // 3rd string
    case B  = "B"   // 2nd string
    case e1 = "e"   // 1st string (high e, thinnest)

    var thickness: Double {
        switch self {
        case .E6: return 6.0
        case .A:  return 5.0
        case .D:  return 4.0
        case .G:  return 3.0
        case .B:  return 2.0
        case .e1: return 1.0
        }
    }
}


struct FingerPlacement: Hashable {
    var string: GuitarString
    var fretNumber: Int
    var fingerNumber: Int  // 1=index, 2=middle, 3=ring, 4=pinky, 0=open, -1=muted
}

struct Chord: Identifiable, Hashable {
    var name: String
    var id: String
    var placements: [FingerPlacement]
    var chordPairs: [String] = []
    var soundFileName: String
    
    func getFingerNumber(string: GuitarString, fret: Int) -> Int? {
        let matchingElement: FingerPlacement? = placements.first { p in
            p.fretNumber == fret && p.string == string
        }
        
        return matchingElement?.fingerNumber
    }
    
    func isStringStrummed(for string: GuitarString) -> Bool {
        return placements.contains { p in
            p.string == string
        }
    }
}
