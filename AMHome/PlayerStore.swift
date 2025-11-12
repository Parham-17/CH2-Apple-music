import SwiftUI
import Combine

final class PlayerStore: ObservableObject {

    @Published var nowPlaying: NowPlaying? = NowPlaying(
        title: "Radioactive",
        artist: "Imagine Dragons",
        artworkColor: .purple
    )

    @Published var isPlaying: Bool = true

    func play(item: MusicItem) {
        nowPlaying = NowPlaying(
            title: item.title,
            artist: item.subtitle,
            artworkColor: item.artworkColor
        )
        isPlaying = true
    }

    func togglePlayPause() {
        guard nowPlaying != nil else { return }
        isPlaying.toggle()
    }
}
