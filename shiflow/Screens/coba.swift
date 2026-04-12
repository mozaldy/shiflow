//
//  coba.swift
//  shiflow
//
//  Created by Jose Putra Perdana Taneo on 10/04/26.
//

import SwiftUI
import AVFoundation

struct coba: View {
    @Environment(MetronomeManager.self) private var metronome

    // CHANGE THIS to the actual BPM of your "beat.mp3" file
    let originalBpm: Double = 115.0
    @State private var tempo: Double = 90.0
    
    let beatSound = Bundle.main.url(forResource: "beat", withExtension: "mp3")
    @State private var soundPlayer: AVAudioPlayer?
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Button("Play Sound") {
                    playSound()
                }
                .buttonStyle(.borderedProminent)
                
                Button("Stop Sound") {
                    stopSound()
                }
                .buttonStyle(.bordered)
                
                Button("Reset") {
                    resetSound()
                }
                .buttonStyle(.bordered)
            }
            .onAppear {
                preparePlayer()
            }
            // Listen for changes in the MetronomeManager's tempo
            .onChange(of: metronome.tempo) { oldValue, newValue in
                updateTempo()
            }
            
            VStack {
                Slider(value: $tempo, in: 40...240, step: 1)
                    .tint(.primaryDarkBrown)
                    .onChange(of: tempo) { oldValue, newValue in
                        metronome.updateTempo(to: tempo)
                    }
                Text("Audio Syncing to: \(Int(metronome.tempo)) BPM")
                    .font(.headline)
                Text("Playback Rate: \(String(format: "%.2f", calculateRate()))x")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            .padding()
        }
    }
    
    // Helper to calculate the multiplier
    private func calculateRate() -> Float {
        return Float(metronome.tempo / originalBpm)
    }
    
    private func preparePlayer() {
        guard let url = beatSound else {
            print("Sound file not found")
            return
        }
        
        do {
            soundPlayer = try AVAudioPlayer(contentsOf: url)
            
            // Enable rate changes and set initial tempo from manager
            soundPlayer?.enableRate = true
            soundPlayer?.rate = calculateRate()
            
            soundPlayer?.prepareToPlay()
            soundPlayer?.numberOfLoops = -1
        } catch {
            print("Could not create audio player: \(error)")
        }
    }
    
    private func updateTempo() {
        soundPlayer?.rate = calculateRate()
    }
    
    private func playSound() {
        soundPlayer?.play()
    }
    
    private func stopSound() {
        soundPlayer?.stop()
    }
    
    private func resetSound() {
        soundPlayer?.stop()
        soundPlayer?.currentTime = 0
    }
}

#Preview {
    coba()
        .environment(MetronomeManager())
}
