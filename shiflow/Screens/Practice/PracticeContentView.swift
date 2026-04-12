import SwiftUI

struct PracticeContentView: View {
    @StateObject private var router = PracticeRouter()

    var body: some View {
        VStack(spacing: 24) {
            Text("Practice Flow")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Button("Start Practice") {
                router.startPractice()
            }
            .foregroundStyle(.white)
            .padding()
            .background(Color.primaryDarkBrown)
            .clipShape(Capsule())
        }
        .fullScreenCover(isPresented: $router.isPracticing) {
            PracticeFlowContainer()
                .environmentObject(router)
        }
    }
}

struct PracticeFlowContainer: View {
    @EnvironmentObject private var router: PracticeRouter
//    @StateObject private var pushUpBeat = BeatTimer(bpm: 60)
//    @StateObject private var moonWalkBeat = BeatTimer(bpm: 60)
//    @StateObject private var rapidFireBeat = BeatTimer(bpm: 80)
    
    var body: some View {
        Group {
            switch router.activeTab {
            case .pushUp:
                FingerPushUpScreen(chordA: aMinor, chordB: dMajor)
            case .moonWalk:
                FingerMoonWalkScreen(chordA: aMinor, chordB: dMajor)
            case .rapidFire:
                FingerRapidFireScreen(chordA: aMinor, chordB: dMajor)
            }
        }
    }
}

#Preview {
    PracticeContentView()
}
