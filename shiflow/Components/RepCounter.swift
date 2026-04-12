import SwiftUI
import UIKit
internal import Combine

struct RepCounter: View {
    @Environment(MetronomeManager.self) private var metronome
    
    @State private var progress: Double = 0
    
    let timerInterval: TimeInterval = 0.05
    let timer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()
    
    var body: some View {
        HStack(spacing: 20) {
            ForEach(1...10, id: \.self) { angka in
                ProgressIcon(progress: progress, id: angka)
            }
            .onReceive(timer) { _ in
                if !metronome.isPlaying {
                    progress += (timerInterval * (60.0 / 60.0)) / 4.0
                }
            }
        }
        .onChange(of: metronome.beatCount) { oldVal, newVal in
            if newVal == 0 {
                progress = 0
                return
            }
            
            let targetProgress = Double(newVal) / Double(metronome.beatsPerMeasure)
            
            withAnimation(.linear(duration: 60.0 / metronome.tempo)) {
                progress = targetProgress
            }
        }
    }
    
    
    struct ProgressIcon: View {
        var progress: Double
        var id: Int
        
        private var maxIcons: Double { 10.0 }
        
        private var isOddCycle: Bool {
            let cycle = Int(max(0, progress) / maxIcons)
            return cycle % 2 != 0
        }
        
        private var effectiveProgress: Double {
            progress.truncatingRemainder(dividingBy: maxIcons)
        }
        
        var body: some View {
            ZStack {
                Circle()
                // We subtract (id - 1) so that id=1 starts transitioning from progress 0 to 1 and id=2 starts from progress -1 to 1, and so on to the nth id
                    .fill(color(effectiveProgress - Double(id - 1), isOddCycle: isOddCycle))
                    .frame(width: 30, height: 30)
                Text("\(id)")
                    .foregroundColor(.white)
            }
        }
        
        func color(_ clampedInput: Double, isOddCycle: Bool) -> Color {
            let baseStartColor = UIColor(named: "PrimaryDarkBrown") ?? .brown
            let baseEndColor = UIColor(named: "PrimaryLightBrown") ?? .systemBrown
            
            let startColor = isOddCycle ? baseEndColor : baseStartColor
            let endColor = isOddCycle ? baseStartColor : baseEndColor
            
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
            
            let clampedProgress = min(max(clampedInput, 0), 1)
            
            return Color(
                red: startRed + (endRed - startRed) * clampedProgress,
                green: startGreen + (endGreen - startGreen) * clampedProgress,
                blue: startBlue + (endBlue - startBlue) * clampedProgress,
                opacity: startAlpha + (endAlpha - startAlpha) * clampedProgress
            )
        }
    }
}

#Preview {
    RepCounter()
        .environment(MetronomeManager())
}
