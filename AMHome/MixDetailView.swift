import SwiftUI

struct MixDetailView: View {
    let mix: MusicItem

    @EnvironmentObject private var player: PlayerStore
    @Environment(\.dismiss) private var dismiss

    // Fake track list for now – you can replace with real data later
    private var tracks: [MusicItem] {
        (1...15).map { index in
            MusicItem(
                title: "Track \(index)",
                subtitle: "Apple Music for Parham",
                artworkColor: mix.artworkColor
            )
        }
    }

    var body: some View {
        ZStack {
            // 🔥 FULLSCREEN ANIMATED BACKGROUND (blurred)
            AnimatedMusicCard(
                title: "",
                subtitle: "",
                footnote: "",
                colors: palette(for: mix.artworkColor),
                prominentColor: mix.artworkColor,
                width: UIScreen.main.bounds.width,
                height: UIScreen.main.bounds.height * 0.9,
                cornerRadius: 80,
                style: .blobs
            )
            .scaleEffect(1.45)     // fill everything
            .blur(radius: 35)      // remove card look
            .opacity(0.85)
            .ignoresSafeArea()

            // Slight dark overlay for readability
            Color.black.opacity(0.45)
                .ignoresSafeArea()

            // CONTENT
            ScrollView(.vertical, showsIndicators: true) {
                VStack(alignment: .leading, spacing: 24) {

                    // MARK: Title section – roughly center-ish
                    VStack(alignment: .leading, spacing: 8) {
                        Text(mix.title)
                            .font(.system(size: 38, weight: .bold))
                            .foregroundColor(.white)

                        Text("Apple Music for Parham")
                            .font(.title3.weight(.semibold))
                            .foregroundStyle(.white.opacity(0.95))

                        Text("Updated 6 hr ago")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 80)   // moves it down like real Apple Music
                    .padding(.horizontal, 20)

                    // MARK: Play / Shuffle buttons
                    HStack(spacing: 14) {
                        Button {
                            if let first = tracks.first {
                                player.play(item: first)
                            }
                        } label: {
                            Text("Play")
                                .font(.headline.bold())
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 12)
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.white.opacity(0.95))
                        .foregroundColor(.black)
                        .clipShape(Capsule())

                        Button {
                            if let random = tracks.randomElement() {
                                player.play(item: random)
                            }
                        } label: {
                            HStack(spacing: 6) {
                                Image(systemName: "shuffle")
                                Text("Shuffle")
                            }
                            .font(.headline.bold())
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                        }
                        .buttonStyle(.bordered)
                        .tint(.white.opacity(0.9))
                        .foregroundColor(.black)
                        .clipShape(Capsule())
                    }
                    .padding(.horizontal, 20)

                    // MARK: Track list – with solid dark background
                    VStack(alignment: .leading, spacing: 0) {
                        ForEach(Array(tracks.enumerated()), id: \.offset) { index, track in
                            Button {
                                player.play(item: track)
                            } label: {
                                HStack(spacing: 14) {
                                    Text("\(index + 1)")
                                        .frame(width: 24, alignment: .trailing)
                                        .foregroundStyle(.secondary)

                                    VStack(alignment: .leading, spacing: 2) {
                                        Text(track.title)
                                            .foregroundColor(.white)
                                            .lineLimit(1)
                                        Text(track.subtitle)
                                            .font(.caption)
                                            .foregroundStyle(.secondary)
                                    }

                                    Spacer()

                                    Image(systemName: "ellipsis")
                                        .foregroundStyle(.secondary)
                                }
                                .padding(.horizontal, 20)
                                .padding(.vertical, 10)
                            }
                            .buttonStyle(.plain)

                            if index != tracks.count - 1 {
                                Divider()
                                    .overlay(Color.white.opacity(0.15))
                                    .padding(.leading, 44)
                            }
                        }
                    }
                    .background(Color.black.opacity(0.80)) // solid list background

                    Spacer(minLength: 40)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            // Back button
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title2.weight(.semibold))
                        .padding(10)
                        .background(
                            Circle().fill(.ultraThinMaterial)
                        )
                }
            }

            // Plus + more buttons on the right
            ToolbarItemGroup(placement: .topBarTrailing) {
                Button {
                    // add to library
                } label: {
                    Image(systemName: "plus")
                        .font(.title3.weight(.semibold))
                        .padding(10)
                        .background(
                            Capsule().fill(.ultraThinMaterial)
                        )
                }

                Button {
                    // more actions
                } label: {
                    Image(systemName: "ellipsis")
                        .font(.title3.weight(.semibold))
                        .padding(10)
                        .background(
                            Capsule().fill(.ultraThinMaterial)
                        )
                }
            }
        }
    }

    private func palette(for color: Color) -> [Color] {
        switch color {
        case .red:    return [.red, .orange, .pink, .purple]
        case .pink:   return [.pink, .purple, .indigo, .blue]
        case .blue:   return [.blue, .teal, .mint, .cyan]
        case .teal:   return [.teal, .mint, .blue, .indigo]
        case .green:  return [.green, .teal, .mint, .yellow]
        case .yellow: return [.yellow, .orange, .pink, .red]
        case .indigo: return [.indigo, .purple, .pink, .blue]
        default:      return [.purple, .pink, .indigo, .blue]
        }
    }
}

#Preview {
    NavigationStack {
        MixDetailView(
            mix: MusicItem(
                title: "Heavy Rotation",
                subtitle: "Apple Music for Parham",
                artworkColor: .orange
            )
        )
        .environmentObject(PlayerStore())
    }
    .preferredColorScheme(.dark)
}

