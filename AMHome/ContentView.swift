import SwiftUI

/// Root content view that hosts the main layout.
struct ContentView: View {
    @StateObject private var player = PlayerStore()

    var body: some View {
        RootTabView()
            .environmentObject(player)
    }
}

#Preview {
    ContentView()
        .environmentObject(PlayerStore())
        .preferredColorScheme(.dark)
}
