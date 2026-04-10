import SwiftUI
internal import Combine

class PracticeRouter: ObservableObject {
    @Published var activeTab: PracticeTab = .pushUp
    @Published var isPracticing: Bool = false
    
    func navigate(to destination: PracticeTab) {
        withAnimation(.easeInOut) {
            activeTab = destination
        }
    }
    
    func startPractice() {
        activeTab = .pushUp
        isPracticing = true
    }
}

