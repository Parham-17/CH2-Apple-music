import SwiftUI
import Combine

/// Simple player state shared across the app.
final class PlayerStore: ObservableObject {

    /// Currently selected / playing item.
    @Published var nowPlaying: MusicItem? = nil

    /// Whether playback is active.
    @Published var isPlaying: Bool = false

    // MARK: - Actions

    func play(item: MusicItem) {
        nowPlaying = item
        isPlaying = true
    }

    func togglePlayPause() {
        guard nowPlaying != nil else { return }
        isPlaying.toggle()
    }

    func stop() {
        nowPlaying = nil
        isPlaying = false
    }
}
