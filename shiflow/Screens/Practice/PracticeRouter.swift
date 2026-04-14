import SwiftUI
internal import Combine

class PracticeRouter: ObservableObject {
    @Published var activeTab: PracticeTab = .pushUp1
    @Published var isPracticing: Bool = false
    
    func navigate(to destination: PracticeTab) {
        withAnimation(.easeInOut) {
            activeTab = destination
        }
    }
    
    func startPractice() {
        activeTab = .pushUp1
        isPracticing = true
    }
}

