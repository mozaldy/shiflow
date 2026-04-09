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
    var isPlaying: Bool = false
    
    private var timer: Timer?
    private var highTickPlayer: AVAudioPlayer?
    private var lowTickPlayer: AVAudioPlayer?
    private var debounceTask: Task<Void, Never>? = nil
    
    init() {
        setupAudioPlayer()
    }
    
    func setupAudioPlayer() {
        // Try-catch
        guard let highURL = Bundle.main.url(forResource: "tick1", withExtension: "mp3"),
              let lowURL = Bundle.main.url(forResource: "tick2", withExtension: "mp3") else {
            print("Suara tidak ditemukan")
            return
        }
        do {
            highTickPlayer = try AVAudioPlayer(contentsOf: highURL)
            lowTickPlayer = try AVAudioPlayer(contentsOf: lowURL)
            
            highTickPlayer?.prepareToPlay()
            lowTickPlayer?.prepareToPlay()
        } catch {
            print("Gagal memuat audio player: \(error)")
        }
    }
    
    func startMetronome() {
        stopMetronome()
        let interval = 60.0/tempo
        
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { _ in
            self.playTick()
        }
        isPlaying = true
    }
    
    private func playTick() {
        // Update currentBeat -> play high and low tick
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
    }
    
    
}
