import SwiftUI

/// Root content view that hosts the main layout (for previews / playground).
struct ContentView: View {
    var body: some View {
        RootTabView()
    }
}

#Preview {
    ContentView()
        .environmentObject({
            let store = PlayerStore()
            store.nowPlaying = MusicItem(
                title: "Radioactive",
                subtitle: "Imagine Dragons",
                artworkColor: .purple
            )
            store.isPlaying = true
            return store
        }())
        .preferredColorScheme(.dark)
}
