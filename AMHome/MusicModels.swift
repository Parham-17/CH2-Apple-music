import SwiftUI

/// Basic representation of a music item used in sections.
struct MusicItem: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let subtitle: String
    let artworkColor: Color
}

struct NowPlaying {
    var title: String
    var artist: String
    var artworkColor: Color
}
