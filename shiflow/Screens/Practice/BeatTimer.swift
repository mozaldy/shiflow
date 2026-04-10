//
//  BeatTimer.swift
//  shiflow
//
//  Created by Antigravity on 09/04/26.
//

internal import Combine
import SwiftUI

@MainActor
class BeatTimer: ObservableObject {
    @Published var beatCount: Int = 0
    @Published var isPlaying: Bool = false
    @Published var bpm: Double

    private var timer: Timer?

    init(bpm: Double = 60) {
        self.bpm = bpm
    }

    func toggle() {
        isPlaying ? stop() : start()
    }

    func start() {
        guard !isPlaying else { return }
        isPlaying = true
        beatCount = 1
        scheduleTimer()
    }

    func stop() {
        isPlaying = false
        timer?.invalidate()
        timer = nil
    }

    func reschedule() {
        guard isPlaying else { return }
        scheduleTimer()
    }

    private func scheduleTimer() {
        timer?.invalidate()
        let interval = 60.0 / bpm
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { [weak self] _ in
            self?.beatCount += 1
        }
    }

    deinit {
        timer?.invalidate()
    }
}

// MARK: - BPM Controls View
struct BPMControls: View {
    @ObservedObject var beat: BeatTimer
    var body: some View {
        VStack(spacing: 12) {
            Text("\(Int(beat.bpm)) BPM")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(.primaryDarkBrown)
                .multilineTextAlignment(.center).frame(width: 50)
        }
        .padding(.horizontal, 30)
        .onChange(of: beat.bpm) {
            beat.reschedule()
        }
    }
}
// MARK: - Beat Indicator View
struct BeatIndicator: View {
    let currentBeat: Int
    let totalBeats: Int
    let isPlaying: Bool
    var body: some View {
        VStack(spacing: 12) {
            ForEach(1...totalBeats, id: \.self) { beat in
                let isActive = isPlaying && beat == currentBeat
                let isDownbeat = beat == 1
                Circle()
                    .fill(isActive ? (isDownbeat ? Color.primaryDarkBrown : Color.primaryLightBrown) : Color.primaryLightBrown.opacity(0.3))
                    .frame(width: isDownbeat ? 20 : 14, height: isDownbeat ? 20 : 14)
                    .scaleEffect(isActive ? 1.2 : 1.0)
                    .animation(.spring(duration: 0.1), value: isActive)
            }
        }
    }
}

