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
    
    var strumTrigger: Int
    
    @State private var isDownStrum: Bool = true
    
    
    var body: some View {
        
        Text(chord.name).padding()
        VStack(spacing: 0){ // container string
            
            
            ForEach(Array(GuitarString.allCases.enumerated()), id: \.element) { index, guitarString in
                let isGuitarStringStrummed = chord.isStringStrummed(for: guitarString)
                
                GuitarStringRow(
                    guitarString: guitarString, // Your bug fix applied!
                    isGuitarStringStrummed: isGuitarStringStrummed,
                    index: index,
                    strumTrigger: strumTrigger,
                    isDownStrum: isDownStrum
                )
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
    
    var index: Int
    var strumTrigger: Int
    var isDownStrum: Bool
    
    @State private var isFlashingGreen: Bool = false
    
    var stringThickness: Double {
        switch guitarString {
        case .E6: return 6.0
        case .A:  return 5.0
        case .D:  return 4.0
        case .G:  return 3.0
        case .B:  return 2.0
        case .e1: return 1.0
        }
    }
    
    var body: some View {
        Rectangle()
        // If flashing green, show green, otherwise, show normal strummed/unstrummed colors
            .fill(isFlashingGreen ? Color.green : (isGuitarStringStrummed ? Color.black : Color.red))
            .frame(height: stringThickness)
            .frame(height: 40)
            .onChange(of: strumTrigger) {
                guard isGuitarStringStrummed else { return }
                triggerFlash()
            }
    }
    
    private func triggerFlash() {
        Task {
            let maxIndex = GuitarString.allCases.count - 1
            
            let delayMultiplier = isDownStrum ? index : (maxIndex - index)
            
            let staggerDuration: Double = 0.05
            let totalDelay = Double(delayMultiplier) * staggerDuration
            
            try? await Task.sleep(nanoseconds: UInt64(totalDelay * 1_000_000_000))
            
            withAnimation(.interactiveSpring) {
                isFlashingGreen = true
            }
            
            try? await Task.sleep(nanoseconds: 150_000_000)
            
            withAnimation(.easeInOut(duration: 0.2)) {
                isFlashingGreen = false
            }
        }
    }
}




#Preview {
    struct PreviewWrapper: View {
        @State private var strumTrigger = 0
        
        var body: some View {
            VStack(spacing: 50) {
                StrumGuitar(chord: cMajor, isActive: true, strumTrigger: strumTrigger)
                
                Button(action: {
                    strumTrigger += 1
                }) {
                    Text("Strum!")
                        .font(.title2)
                        .bold()
                        .padding()
                        .frame(width: 200)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
            }
        }
    }
    
    return PreviewWrapper()
}
