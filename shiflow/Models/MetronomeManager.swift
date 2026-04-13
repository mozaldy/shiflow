//
//  MetronomeManager.swift
//  shiflow
//
//  Created by Jose Putra Perdana Taneo on 09/04/26.
//

import Foundation
import SwiftUI
import AVFoundation

@Observable
class MetronomeManager {
    var tempo: Double = 90.0
    var beatsPerMeasure: Int = 4
    var currentBeat: Int = 0
    var beatCount: Int = 0
    
    let originalBeatBpm: Double = 115.0
    
    var isPlaying: Bool = false
    
    var barIndex: Int {
        max(0, (self.beatCount - 1) / self.beatsPerMeasure)
    }
    
    var beatInBar: Int {
        guard self.beatCount > 0 else { return 0 }
        return ((self.beatCount - 1) % self.beatsPerMeasure) + 1
    }
    
    var isFirstBeatOfBar: Bool {
        beatInBar == 1
    }
    
    var isEvenBar: Bool {
        barIndex % 2 == 0
    }
    
    private var timer: Timer?
    private var highTickPlayer: AVAudioPlayer?
    private var lowTickPlayer: AVAudioPlayer?
    private var beatPlayer: AVAudioPlayer?
    private var debounceTask: Task<Void, Never>? = nil
    
    init() {
        setupAudioPlayer()
    }
    
    private func calculateRate() -> Float {
        return Float(tempo / originalBeatBpm)
    }
    
    func setupAudioPlayer() {
        // Try-catch
        guard let highURL = Bundle.main.url(forResource: "tick1", withExtension: "mp3"),
              let lowURL = Bundle.main.url(forResource: "tick2", withExtension: "mp3"),
            let beatURL = Bundle.main.url(forResource: "beat", withExtension: "mp3") else {
            print("Suara tidak ditemukan")
            return
        }
        do {
            highTickPlayer = try AVAudioPlayer(contentsOf: highURL)
            lowTickPlayer = try AVAudioPlayer(contentsOf: lowURL)
            beatPlayer = try AVAudioPlayer(contentsOf: beatURL)
            
            beatPlayer?.enableRate = true
            beatPlayer?.rate = calculateRate()
            beatPlayer?.numberOfLoops = -1
            
            highTickPlayer?.prepareToPlay()
            lowTickPlayer?.prepareToPlay()
            beatPlayer?.prepareToPlay()
        } catch {
            print("Gagal memuat audio player: \(error)")
        }
    }
    
    func startMetronome() {
        stopMetronome()
        startBeat()
        let interval = 60.0/tempo
        
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { _ in
            self.playTick()
        }
        isPlaying = true
    }
    
    func startMetronomeOnly() {
        stopMetronome()
        let interval = 60.0/tempo
        
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { _ in
            self.playTick()
        }
        isPlaying = true
    }
    
    func startBeat() {
        beatPlayer?.currentTime = 0
        beatPlayer?.play()
    }
    
    func stopBeat() {
        beatPlayer?.stop()
        beatPlayer?.currentTime = 0
    }
    
    func pauseBeat() {
        beatPlayer?.pause()
    }
    
    private func playTick() {
        beatCount += 1
        // Update currentBeat -> play high and low tick
        
        // play beat exactly on the first beat
        if beatCount == 1 {
            startBeat()
        }
        
        currentBeat += 1
        if currentBeat > beatsPerMeasure {
            // reset current beat
            currentBeat = 1
        }
        
        if currentBeat == 1 {
            // play high tick waktu beat 1
            highTickPlayer?.currentTime = 0
            highTickPlayer?.play()
        } else {
            // sisanya pakai low tick
            lowTickPlayer?.currentTime = 0
            lowTickPlayer?.play()
        }
    }
    
    func updateTempo(to newTempo: Double) {
        // Batalin task lama, tunggu 0.1s, trus panggil lagi startMetronome
        tempo = newTempo
        
        debounceTask?.cancel()
        
        //Buat task baru tapi tunggu 0.1s
        debounceTask = Task {
            try? await Task.sleep(nanoseconds: 100_000_000)
            if Task.isCancelled { return }
            
            // kalau sedang berbunyi, restart dengan tempo baru
            if isPlaying {
                startMetronome()
            }
        }
    }
    
    func stopMetronome() {
        // stop timer yang lagi jalan
        timer?.invalidate()
        // reset
        timer = nil
        isPlaying = false
        currentBeat = 0
        beatCount = 0
        stopBeat()
    }
    
    func pauseMetronome() {
        timer?.invalidate()
        timer = nil
        isPlaying = false
        pauseBeat()
    }
    
}

struct TempoView: View {
    var manager: MetronomeManager
    
    var body: some View {
        VStack(spacing: 12) {
            Text("\(Int(manager.tempo)) BPM")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(.primaryDarkBrown)
                .multilineTextAlignment(.center)
                .frame(minWidth: 80)
        }
        .padding(.horizontal, 30)
    }
}

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
