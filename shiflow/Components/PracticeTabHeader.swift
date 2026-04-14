import SwiftUI

enum PracticeTab: String, CaseIterable {
    case pushUp1 = "Push Up 1"
    case pushUp2 = "Push Up 2"
    case moonWalk = "Moon Walk"
    case rapidFire = "Rapid Fire"
}

struct PracticeTabHeader: View {
    let activeTab: PracticeTab
    
    var body: some View {
        HStack(spacing: 20) {
            ForEach(PracticeTab.allCases, id: \.self) { tab in
                let isActive = tab == activeTab
                
                Button(tab.rawValue) {
                    // To do: wire up navigation if needed later
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .fontWeight(.semibold)
                .foregroundStyle(isActive ? .white : .primaryDarkBrown)
                .background(isActive ? Color.primaryDarkBrown : Color.clear)
                .clipShape(Capsule())
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 50)
    }
}

#Preview {
    VStack {
        PracticeTabHeader(activeTab: .pushUp1)
        PracticeTabHeader(activeTab: .pushUp2)
        PracticeTabHeader(activeTab: .moonWalk)
        PracticeTabHeader(activeTab: .rapidFire)
    }
}
