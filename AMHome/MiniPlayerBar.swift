import SwiftUI

struct MiniPlayerBar: View {
    @EnvironmentObject private var player: PlayerStore
    @Environment(\.tabViewBottomAccessoryPlacement) private var placement

    var body: some View {
        if let item = player.nowPlaying {
            HStack(spacing: 10) {

                // Artwork (unchanged)
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(item.artworkColor)
                    .frame(width: 32, height: 32)

                // Titles (unchanged)
                VStack(alignment: .leading, spacing: 2) {
                    Text(item.title)
                        .font(.callout.weight(.semibold))
                        .foregroundColor(.primary)
                        .lineLimit(1)

                    Text(item.subtitle)
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                }

                Spacer()

                // 🔹 Play / pause (smaller)
                Button {
                    player.togglePlayPause()
                } label: {
                    Image(systemName: player.isPlaying ? "pause.fill" : "play.fill")
                        .font(.body)          // smaller
                }
                .buttonStyle(.plain)
                .padding(.horizontal, 2)

                // 🔹 Next button (smaller)
                Button {
                    // TODO
                } label: {
                    Image(systemName: "forward.fill")
                        .font(.body)          // smaller
                }
                .buttonStyle(.plain)
                .padding(.trailing, 2)
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
        }
    }
}
