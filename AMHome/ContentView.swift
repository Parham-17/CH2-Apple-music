import SwiftUI

/// Root content view that hosts the main layout.
struct ContentView: View {
    var body: some View {
        RootTabView()
    }
}

#Preview {
    ContentView()
        .environmentObject(PlayerStore())
}
