//
//  ChordData.swift
//  shiflow
//
//  Created by Mohammad Rizaldy Ramadhan on 08/04/26.
//

import Foundation

// MARK: - Common Open Chords

let cMajor = Chord(name: "C Major", placements: [
    FingerPlacement(string: .A,  fretNumber: 3, fingerNumber: 3),  // ring on 5th string, 3rd fret
    FingerPlacement(string: .D,  fretNumber: 2, fingerNumber: 2),  // middle on 4th string, 2nd fret
    FingerPlacement(string: .G,  fretNumber: 0, fingerNumber: 0),  // open
    FingerPlacement(string: .B,  fretNumber: 1, fingerNumber: 1),  // index on 2nd string, 1st fret
    FingerPlacement(string: .e1, fretNumber: 0, fingerNumber: 0),  // open
    // E6 string is muted (not played)
])

let dMajor = Chord(name: "D Major", placements: [
    // E6 and A strings are muted
    FingerPlacement(string: .D,  fretNumber: 0, fingerNumber: 0),  // open
    FingerPlacement(string: .G,  fretNumber: 2, fingerNumber: 1),  // index on 3rd string, 2nd fret
    FingerPlacement(string: .B,  fretNumber: 3, fingerNumber: 3),  // ring on 2nd string, 3rd fret
    FingerPlacement(string: .e1, fretNumber: 2, fingerNumber: 2),  // middle on 1st string, 2nd fret
])

let eMajor = Chord(name: "E Major", placements: [
    FingerPlacement(string: .E6, fretNumber: 0, fingerNumber: 0),  // open
    FingerPlacement(string: .A,  fretNumber: 2, fingerNumber: 2),  // middle on 5th string, 2nd fret
    FingerPlacement(string: .D,  fretNumber: 2, fingerNumber: 3),  // ring on 4th string, 2nd fret
    FingerPlacement(string: .G,  fretNumber: 1, fingerNumber: 1),  // index on 3rd string, 1st fret
    FingerPlacement(string: .B,  fretNumber: 0, fingerNumber: 0),  // open
    FingerPlacement(string: .e1, fretNumber: 0, fingerNumber: 0),  // open
])

let eMinor = Chord(name: "E Minor", placements: [
    FingerPlacement(string: .E6, fretNumber: 0, fingerNumber: 0),  // open
    FingerPlacement(string: .A,  fretNumber: 2, fingerNumber: 2),  // middle on 5th string, 2nd fret
    FingerPlacement(string: .D,  fretNumber: 2, fingerNumber: 3),  // ring on 4th string, 2nd fret
    FingerPlacement(string: .G,  fretNumber: 0, fingerNumber: 0),  // open
    FingerPlacement(string: .B,  fretNumber: 0, fingerNumber: 0),  // open
    FingerPlacement(string: .e1, fretNumber: 0, fingerNumber: 0),  // open
])

let aMajor = Chord(name: "A Major", placements: [
    // E6 string is muted
    FingerPlacement(string: .A,  fretNumber: 0, fingerNumber: 0),  // open
    FingerPlacement(string: .D,  fretNumber: 2, fingerNumber: 1),  // index on 4th string, 2nd fret
    FingerPlacement(string: .G,  fretNumber: 2, fingerNumber: 2),  // middle on 3rd string, 2nd fret
    FingerPlacement(string: .B,  fretNumber: 2, fingerNumber: 3),  // ring on 2nd string, 2nd fret
    FingerPlacement(string: .e1, fretNumber: 0, fingerNumber: 0),  // open
])

let aMinor = Chord(name: "A Minor", placements: [
    // E6 string is muted
    FingerPlacement(string: .A,  fretNumber: 0, fingerNumber: 0),  // open
    FingerPlacement(string: .D,  fretNumber: 2, fingerNumber: 2),  // middle on 4th string, 2nd fret
    FingerPlacement(string: .G,  fretNumber: 2, fingerNumber: 3),  // ring on 3rd string, 2nd fret
    FingerPlacement(string: .B,  fretNumber: 1, fingerNumber: 1),  // index on 2nd string, 1st fret
    FingerPlacement(string: .e1, fretNumber: 0, fingerNumber: 0),  // open
])

let gMajor = Chord(name: "G Major", placements: [
    FingerPlacement(string: .E6, fretNumber: 3, fingerNumber: 2),  // middle on 6th string, 3rd fret
    FingerPlacement(string: .A,  fretNumber: 2, fingerNumber: 1),  // index on 5th string, 2nd fret
    FingerPlacement(string: .D,  fretNumber: 0, fingerNumber: 0),  // open
    FingerPlacement(string: .G,  fretNumber: 0, fingerNumber: 0),  // open
    FingerPlacement(string: .B,  fretNumber: 0, fingerNumber: 0),  // open
    FingerPlacement(string: .e1, fretNumber: 3, fingerNumber: 3),  // ring on 1st string, 3rd fret
])

let fMajor = Chord(name: "F Major", placements: [
    // Barre chord - finger 1 barres all strings at fret 1
    FingerPlacement(string: .E6, fretNumber: 1, fingerNumber: 1),  // barre (index)
    FingerPlacement(string: .A,  fretNumber: 3, fingerNumber: 3),  // ring on 5th string, 3rd fret
    FingerPlacement(string: .D,  fretNumber: 3, fingerNumber: 4),  // pinky on 4th string, 3rd fret
    FingerPlacement(string: .G,  fretNumber: 2, fingerNumber: 2),  // middle on 3rd string, 2nd fret
    FingerPlacement(string: .B,  fretNumber: 1, fingerNumber: 1),  // barre (index)
    FingerPlacement(string: .e1, fretNumber: 1, fingerNumber: 1),  // barre (index)
])
