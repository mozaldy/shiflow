//
//  RepCounter.swift
//  shiflow
//
//  Created by Devon on 07/04/26.
//

import SwiftUI
import UIKit
internal import Combine

struct RepCounter: View {
    @State private var progress: Double = 0
    var tempo: Double = 0.05
    
    let timer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()
    
    var body: some View {
        HStack(spacing: 20) {
            ForEach(1...10, id: \.self) { angka in
                ProgressIcon(progress: progress, id: angka)
            }
            .onReceive(timer) { _ in
                // Each circle progresses at different speed
                progress += tempo
                
            }
        }
    }
}


struct ProgressIcon: View {
    var progress: Double
    var id: Int
    
    var body: some View {
        ZStack {
            Circle()
                .fill(color(progress - Double(id)))
                .frame(width: 30, height: 30)
                .offset(x: 0, y: -110)
            Text("\(id)")
                .foregroundColor(.white)                   .offset(x: 0, y: -110)
        }
    }
    
    func color(_ progress: Double) -> Color {
        let startColor = UIColor(named: "PrimaryDarkBrown") ?? .brown
        let endColor = UIColor(named: "PrimaryLightBrown") ?? .systemBrown
        
        var startRed: CGFloat = 0
        var startGreen: CGFloat = 0
        var startBlue: CGFloat = 0
        var startAlpha: CGFloat = 0
        var endRed: CGFloat = 0
        var endGreen: CGFloat = 0
        var endBlue: CGFloat = 0
        var endAlpha: CGFloat = 0
        
        startColor.getRed(&startRed, green: &startGreen, blue: &startBlue, alpha: &startAlpha)
        endColor.getRed(&endRed, green: &endGreen, blue: &endBlue, alpha: &endAlpha)
        
        let clampedProgress = min(max(progress, 0), 1)
        
        return Color(
            red: startRed + (endRed - startRed) * clampedProgress,
            green: startGreen + (endGreen - startGreen) * clampedProgress,
            blue: startBlue + (endBlue - startBlue) * clampedProgress,
            opacity: startAlpha + (endAlpha - startAlpha) * clampedProgress
        )
    }
}

#Preview {
    RepCounter()
}
