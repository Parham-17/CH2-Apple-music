import SwiftUI

struct MiniPlayerView: View {

    @EnvironmentObject private var player: PlayerStore
    @Environment(\.tabViewBottomAccessoryPlacement) private var placement

    let nowPlaying: NowPlaying

    // When the accessory is "inside" the tab bar area.
    private var isInline: Bool {
        placement == .inline
    }

    var body: some View {
        HStack(spacing: 12) {
            // Artwork square
            RoundedRectangle(cornerRadius: 10)
                .fill(nowPlaying.artworkColor)
                .frame(width: 40, height: 40)

            // Texts
            VStack(alignment: .leading, spacing: 2) {
                Text(nowPlaying.title)
                    .font(.subheadline.weight(.semibold))
                    .lineLimit(1)

                Text(nowPlaying.artist)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
            }

            Spacer()

            // Play / Pause
            Button {
                player.togglePlayPause()
            } label: {
                Image(systemName: player.isPlaying ? "pause.fill" : "play.fill")
                    .font(.title2)
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)

        // Width + corner radius react to placement:
        // - expanded: wide pill above bar
        // - inline: compact pill that fits into the bar
        .frame(
            maxWidth: isInline ? 260 : .infinity,
            alignment: .leading
        )
       
        .clipShape(
            RoundedRectangle(
                cornerRadius: isInline ? 18 : 22,
                style: .continuous
            )
        )
        .shadow(color: .black.opacity(0.25), radius: 10, x: 0, y: 4)
        .animation(.easeInOut(duration: 0.25), value: isInline)
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        MiniPlayerView(
            nowPlaying: NowPlaying(
                title: "Radioactive",
                artist: "Imagine Dragons",
                artworkColor: .purple
            )
        )
        .environmentObject(PlayerStore())
        .padding()
    }
}
