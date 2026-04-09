//
//  shiflowApp.swift
//  shiflow
//
//  Created by Mohammad Rizaldy Ramadhan on 06/04/26.
//

import SwiftUI
import SwiftData

@main
struct shiflowApp: App {
    @State private var metronomeManager = MetronomeManager()
    
    var body: some Scene {
        WindowGroup {
            MainScreen()
                .environment(metronomeManager)
        }
    }
}
