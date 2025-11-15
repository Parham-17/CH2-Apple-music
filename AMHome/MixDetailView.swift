import SwiftUI

struct MixDetailView: View {
    let mix: MusicItem

    @EnvironmentObject private var player: PlayerStore
    @Environment(\.dismiss) private var dismiss

    // Fake tracks for now
    private var tracks: [MusicItem] {
        (1...20).map { index in
            MusicItem(
                title: "Track \(index)",
                subtitle: "Apple Music for Parham",
                artworkColor: mix.artworkColor
            )
        }
    }

    var body: some View {
        GeometryReader { geo in
            // Use the SCREEN height so hero size is consistent
            // (both in preview and when opened from ContentView).
            let screenHeight = UIScreen.main.bounds.height
            let heroHeight = screenHeight * 0.75   // big hero (≈ 3/4+)

            ZStack {
                Color.black.ignoresSafeArea()

                ScrollView(.vertical, showsIndicators: true) {
                    VStack(spacing: 0) {

                        // MARK: - HERO (animated, scrolls with content)
                        ZStack {
                            // Animated gradient background
                            AnimatedMusicCard(
                                title: "",
                                subtitle: "",
                                footnote: "",
                                colors: palette(for: mix.artworkColor),
                                prominentColor: mix.artworkColor,
                                width: geo.size.width,
                                height: heroHeight + 200,   // overshoot to avoid hard edge
                                cornerRadius: 80,
                                style: .blobs
                            )
                            .scaleEffect(1.5)
                            .blur(radius: 40)
                            .opacity(0.95)
                            .ignoresSafeArea(edges: .top)

                            // Darken bottom so text is readable
                            LinearGradient(
                                colors: [
                                    .clear,
                                    .clear,
                                    .black.opacity(0.25),
                                    .black.opacity(0.8)
                                ],
                                startPoint: .top,
                                endPoint: .bottom
                            )

                            // MARK: - Title Block + Buttons (centered)
                            VStack(alignment: .center, spacing: 8) {
                                Text(mix.title)
                                    .font(.system(size: 25, weight: .bold))
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)

                                Text("Apple Music for Parham")
                                    .font(.title3)
                                    .foregroundColor(.white.opacity(0.95))
                                    .multilineTextAlignment(.center)

                                Text("Updated 6 hr ago")
                                    .font(.caption)
                                    .foregroundColor(.white.opacity(0.65))
                                    .multilineTextAlignment(.center)

                                // MARK: - Play / Shuffle buttons
                                HStack(spacing: 14) {
                                    // PLAY BUTTON
                                    Button {
                                        player.play(item: mix)
                                    } label: {
                                        HStack(spacing: 6) {
                                            Image(systemName: "play.fill")
                                            Text("Play")
                                        }
                                        .font(.headline)
                                        .frame(width: 150, height: 50)
                                        .background(Color.white)
                                        .foregroundColor(.black)
                                        .clipShape(Capsule())
                                    }
                                    .buttonStyle(.plain)

                                    // SHUFFLE BUTTON
                                    Button {
                                        // shuffle logic
                                    } label: {
                                        HStack(spacing: 6) {
                                            Image(systemName: "shuffle")
                                            Text("Shuffle")
                                        }
                                        .font(.headline)
                                        .frame(width: 150, height: 50)            // SAME SIZE + BIGGER
                                        .background(Color.white.opacity(0.12))
                                        .foregroundColor(.white)
                                        .overlay(
                                            Capsule()
                                                .stroke(Color.white.opacity(0.7), lineWidth: 1)
                                        )
                                        .clipShape(Capsule())
                                    }
                                    .buttonStyle(.plain)
                                }
                                .padding(.top, 20)

                            }
                            .padding(.horizontal, 24)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                            .offset(y: -150)   // your working offset
                        }
                        .frame(height: heroHeight)
                        .clipped()

                        // MARK: - TRACK LIST
                        VStack(spacing: 0) {
                            ForEach(Array(tracks.enumerated()), id: \.offset) { index, track in
                                HStack(spacing: 14) {
                                    Text("\(index + 1)")
                                        .frame(width: 26, alignment: .trailing)
                                        .foregroundColor(.secondary)

                                    VStack(alignment: .leading, spacing: 2) {
                                        Text(track.title)
                                            .foregroundColor(.white)
                                            .lineLimit(1)
                                        Text(track.subtitle)
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                    }

                                    Spacer()

                                    Image(systemName: "ellipsis")
                                        .foregroundColor(.secondary)
                                }
                                .padding(.horizontal, 20)
                                .padding(.vertical, 10)

                                if index != tracks.count - 1 {
                                    Divider()
                                        .overlay(Color.white.opacity(0.15))
                                        .padding(.leading, 50)
                                }
                            }
                        }
                        .background(Color.black)
                    }
                }
                // Let content go under the top toolbar (no empty strip)
                .ignoresSafeArea(edges: .top)
            }
        }
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        // MARK: - Liquid Glass toolbar layer
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                }
            }

            ToolbarItemGroup(placement: .topBarTrailing) {
                Button {
                    // add to library
                } label: {
                    Image(systemName: "plus")
                }

                Button {
                    // more actions
                } label: {
                    Image(systemName: "ellipsis")
                }
            }
        }
    }

    // MARK: - Gradient palette helper
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
                title: "Heavy Rotation Mix",
                subtitle: "Apple Music for Parham",
                artworkColor: .purple
            )
        )
        .environmentObject(PlayerStore())
    }
    .preferredColorScheme(.dark)
}
