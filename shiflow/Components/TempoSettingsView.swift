//
//  TempoSettingsView.swift
//  shiflow
//
//  Created by Jose Putra Perdana Taneo on 09/04/26.
//

import SwiftUI

struct TempoSettingsView: View {
    @Environment(MetronomeManager.self) private var metronome
    
    @Binding var isShowing: Bool
    @State private var draftTempo: Double = 90.0
    @State private var originalTempo: Double = 0.0
    
    let minTempo: Double = 40
    let maxTempo: Double = 240
    let scales = [40, 100, 150, 200, 240]
    
    
    var body: some View {
        VStack() {
            Text("Choose Your Tempo")
                .font(.system(.title2))
                .bold()
                .padding(.bottom, 6)
            
            HStack {
                Button("-10"){
                    draftTempo -= 10
                }
                .buttonStyle(.glass)
                .font(.caption)
                
                Text("\(Int(draftTempo))")
                    .font(.system(size: 48, weight: .bold))
                    .foregroundStyle(metronome.currentBeat%2 != 1 ? Color.black.opacity(0.7) : Color.black.opacity(0.4))
                    .padding(1)
                    .padding(.leading, 30)
                    .padding(.trailing, 30)
                    .background(
                        RoundedRectangle(cornerRadius: 30)
                            .foregroundStyle(metronome.currentBeat%2 != 1 ? Color.gray.opacity(0.4) : Color.red.opacity(0.1))
                    )
                    .scaleEffect(metronome.currentBeat%2 != 1 ? 1.0 : 1.15)
                    .animation(.spring(response: 0.4, dampingFraction: 0.7), value: metronome.currentBeat)
                
                Button("+10"){
                    draftTempo += 10
                }
                .buttonStyle(.glass)
                .font(.caption)
            }
            
            Text("Beat per minute (BPM)")
                .font(.caption)
                .foregroundStyle(.black.opacity(0.6))
                .padding(.top, 0)
                .padding(.bottom, 4)
            
            VStack(spacing: 0) {
                
                Slider(value: $draftTempo, in: minTempo...maxTempo, step: 1)
                    .tint(.primaryDarkBrown)
                    .onChange(of: draftTempo) { oldValue, newValue in
                        metronome.updateTempo(to: draftTempo)
                    }
                
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        ForEach(scales, id: \.self) { scale in
                            // Cari posisi horizontal
                            let percentage = CGFloat((Double(scale) - minTempo) / (maxTempo - minTempo))
                            let xOffset = percentage * geometry.size.width
                            
                            Text("\(scale)")
                                .font(.system(size: 12))
                                .foregroundColor(.gray)
                                // Gunakan frame agar teks rata tengah terhadap titiknya
                                .frame(width: 30)
                                .position(x: xOffset, y: 10)
                        }
                    }
                }
                .frame(height: 30)
            }
            // padding ukuran slider + skala
            //.padding(.horizontal, 250)
            
            
            HStack {
                Button("90"){
                    draftTempo = 90
                }
                .font(.callout)
                .bold()
                .tint(.green)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 6)
                .background(Color.green.opacity(0.7))
                .clipShape(RoundedRectangle(cornerRadius: 30))
                
                Button("120"){
                    draftTempo = 120
                }
                .font(.callout)
                .bold()
                .tint(.green)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 6)
                .background(Color.orange.opacity(0.7))
                .clipShape(RoundedRectangle(cornerRadius: 30))
                
                Button("180"){
                    draftTempo = 180
                }
                .font(.callout)
                .bold()
                .tint(.green)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 6)
                .background(Color.red.opacity(0.7))
                .clipShape(RoundedRectangle(cornerRadius: 30))
            }
            .padding(.bottom, 2)
            
            HStack(spacing: 0) {
                Button("Cancel") {
                    metronome.tempo = originalTempo
                    isShowing = false
                    
                }
                .font(.headline)
                .bold()
                .foregroundStyle(.black)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .background(Color.gray.opacity(0.3))
                .clipShape(RoundedRectangle(cornerRadius: 30))
                
                Spacer()
                
                Button("Set"){
                    metronome.tempo = draftTempo
                    originalTempo = metronome.tempo
                    isShowing = false
                    print(metronome.tempo)
                }
                .font(.headline)
                .bold()
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .background(Color.primaryDarkBrown.opacity(0.8))
                .clipShape(RoundedRectangle(cornerRadius: 30))
            }
            
        }
        .onAppear {
            originalTempo = metronome.tempo
            metronome.startMetronomeOnly()
            draftTempo = metronome.tempo
        }
        .onDisappear {
            metronome.stopMetronome()
        }
    }
}

#Preview {
    @Previewable @State var show: Bool = true
    TempoSettingsView(isShowing: $show)
        .environment(MetronomeManager())
}
