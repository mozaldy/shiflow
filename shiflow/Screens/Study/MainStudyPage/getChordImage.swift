//
//  getChordImage.swift
//  shiflow
//
//  Created by Theressa Natasha Thebez on 08/04/26.
//

extension MainStudyScreen {

    func getChordImage(type: String) -> String {
        switch (selectedChord, type) {
        case (aMinor, "finger"): return "am_chord"
        case (aMinor, "exercise"): return "am_exercise"
        case (aMinor, "strum"): return "am_strum"

        case (cMajor, "finger"): return "c_chord"
        case (cMajor, "exercise"): return "c_exercise"
        case (cMajor, "strum"): return "c_strum"

        case (dMajor, "finger"): return "d_chord"
        case (dMajor, "exercise"): return "d_exercise"
        case (dMajor, "strum"): return "d_strum"

        case (fMajor, "finger"): return "f_chord"
        case (fMajor, "exercise"): return "f_exercise"
        case (fMajor, "strum"): return "f_strum"

        case (eMinor, "finger"): return "em_chord"
        case (eMinor, "exercise"): return "em_exercise"
        case (eMinor, "strum"): return "em_strum"

        case (gMajor, "finger"): return "g_chord"
        case (gMajor, "exercise"): return "g_exercise"
        case (gMajor, "strum"): return "g_strum"

        default:
            return "chord"
        }
    }
}
