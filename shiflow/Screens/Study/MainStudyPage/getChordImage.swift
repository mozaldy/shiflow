//
//  getChordImage.swift
//  shiflow
//
//  Created by Theressa Natasha Thebez on 08/04/26.
//

extension MainStudyScreen {

    func getChordImage(type: String) -> String {
        switch (selectedChord, type) {
        case ("Am", "finger"): return "am_chord"
        case ("Am", "exercise"): return "am_exercise"
        case ("Am", "strum"): return "am_strum"

        case ("C", "finger"): return "c_chord"
        case ("C", "exercise"): return "c_exercise"
        case ("C", "strum"): return "c_strum"

        case ("D", "finger"): return "d_chord"
        case ("D", "exercise"): return "d_exercise"
        case ("D", "strum"): return "d_strum"

        case ("F", "finger"): return "f_chord"
        case ("F", "exercise"): return "f_exercise"
        case ("F", "strum"): return "f_strum"

        case ("Em", "finger"): return "em_chord"
        case ("Em", "exercise"): return "em_exercise"
        case ("Em", "strum"): return "em_strum"

        case ("G", "finger"): return "g_chord"
        case ("G", "exercise"): return "g_exercise"
        case ("G", "strum"): return "g_strum"

        default:
            return "chord"
        }
    }
}
