import SwiftUI

struct HomeView: View {

    @EnvironmentObject private var player: PlayerStore
    @State private var showAccount = false

    // MARK: Data
    private let topPicks: [MusicItem] = [
        MusicItem(title: "SHISH",
                  subtitle: "Portugal. The Man – 7 November",
                  artworkColor: .red),
        MusicItem(title: "Parham Mix",
                  subtitle: "Made for You",
                  artworkColor: .pink),
        MusicItem(title: "Late Night Vibes",
                  subtitle: "Playlist",
                  artworkColor: .blue),
        MusicItem(title: "Focus Now",
                  subtitle: "Instrumental Beats",
                  artworkColor: .teal)
    ]

    private let recentlyPlayed: [MusicItem] = [
        MusicItem(title: "Energy",       subtitle: "Radio Station", artworkColor: .green),
        MusicItem(title: "Feel Good",    subtitle: "Radio Station", artworkColor: .yellow),
        MusicItem(title: "Parham Radio", subtitle: "Radio Station", artworkColor: .orange),
        MusicItem(title: "Chill Beats",  subtitle: "Playlist",      artworkColor: .purple),
        MusicItem(title: "Lo-Fi Coding", subtitle: "Playlist",      artworkColor: .mint),
        MusicItem(title: "Retro Wave",   subtitle: "Playlist",      artworkColor: .indigo)
    ]

    private let twoThousands: [MusicItem] = [
        MusicItem(title: "Leaving Eden",      subtitle: "Antimatter",        artworkColor: .blue),
        MusicItem(title: "Late Goodbye - EP", subtitle: "Poets of the Fall", artworkColor: .brown),
        MusicItem(title: "Don’t Panic",       subtitle: "Coldplay",          artworkColor: .teal),
        MusicItem(title: "Hybrid Theory",     subtitle: "Linkin Park",       artworkColor: .gray),
        MusicItem(title: "American Idiot",    subtitle: "Green Day",         artworkColor: .green),
        MusicItem(title: "Songs About Jane",  subtitle: "Maroon 5",          artworkColor: .red)
    ]

    private let madeForYou: [MusicItem] = [
        MusicItem(title: "Parham Mix",      subtitle: "Personal Mix", artworkColor: .pink),
        MusicItem(title: "Discover Weekly", subtitle: "New for You",  artworkColor: .purple),
        MusicItem(title: "Daily Drive",     subtitle: "Music + News", artworkColor: .orange),
        MusicItem(title: "Chilled Keys",    subtitle: "Instrumental", artworkColor: .teal),
        MusicItem(title: "90s Rewind",      subtitle: "Throwback",    artworkColor: .yellow)
    ]

    private let workout: [MusicItem] = [
        MusicItem(title: "Beast Mode",   subtitle: "Workout Mix", artworkColor: .red),
        MusicItem(title: "HIIT Heat",    subtitle: "Up-tempo",    artworkColor: .orange),
        MusicItem(title: "Run Faster",   subtitle: "BPM 170+",    artworkColor: .green),
        MusicItem(title: "Pump It Up",   subtitle: "EDM",         artworkColor: .blue),
        MusicItem(title: "Gym Classics", subtitle: "Throwback",   artworkColor: .indigo)
    ]

    private let chill: [MusicItem] = [
        MusicItem(title: "Ocean Waves",  subtitle: "Ambient",      artworkColor: .cyan),
        MusicItem(title: "Night City",   subtitle: "Chillhop",     artworkColor: .purple),
        MusicItem(title: "Midnight Tea", subtitle: "Calm",         artworkColor: .mint),
        MusicItem(title: "Deep Focus",   subtitle: "No Lyrics",    artworkColor: .gray),
        MusicItem(title: "Quiet Piano",  subtitle: "Instrumental", artworkColor: .brown)
    ]

    private let jazz: [MusicItem] = [
        MusicItem(title: "Blue Note",   subtitle: "Classic Jazz", artworkColor: .blue),
        MusicItem(title: "Late Night",  subtitle: "Smooth",       artworkColor: .indigo),
        MusicItem(title: "Café Swing",  subtitle: "1930s-50s",    artworkColor: .orange),
        MusicItem(title: "Modern Jazz", subtitle: "Fresh",        artworkColor: .green),
        MusicItem(title: "Sax Stories", subtitle: "Instrumental", artworkColor: .yellow)
    ]

    private let pop: [MusicItem] = [
        MusicItem(title: "Today’s Hits", subtitle: "Pop",       artworkColor: .pink),
        MusicItem(title: "Viral 50",     subtitle: "Trending",  artworkColor: .red),
        MusicItem(title: "Future Pop",   subtitle: "Fresh",     artworkColor: .purple),
        MusicItem(title: "Teen Party",   subtitle: "Fun",       artworkColor: .yellow),
        MusicItem(title: "Electro Pop",  subtitle: "Synth",     artworkColor: .teal)
    ]

    private let metal: [MusicItem] = [
        MusicItem(title: "Energy Metal",  subtitle: "Workout",   artworkColor: .green),
        MusicItem(title: "Classic Metal", subtitle: "Legends",   artworkColor: .gray),
        MusicItem(title: "Prog Assault",  subtitle: "Prog",      artworkColor: .blue),
        MusicItem(title: "Nordic Fire",   subtitle: "Viking",    artworkColor: .brown),
        MusicItem(title: "Core Crash",    subtitle: "Metalcore", artworkColor: .red)
    ]

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 24) {

                // MARK: Header
                HStack {
                    Text("Home")
                        .font(.system(size: 34, weight: .bold))
                        .foregroundColor(.white)

                    Spacer()

                    Button {
                        showAccount = true
                    } label: {
                        ZStack {
                            Circle()
                                .fill(
                                    LinearGradient(
                                        colors: [.pink, .orange],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .frame(width: 36, height: 36)

                            Text("P")
                                .font(.headline.bold())
                                .foregroundColor(.white)
                        }
                    }
                    .buttonStyle(.plain)
                }
                .padding(.horizontal)
                .padding(.top, 12)

                // MARK: Top Picks – animated cards (blobs style)
                VStack(alignment: .leading, spacing: 8) {
                    Text("Top Picks for You")
                        .font(.title2.bold())
                        .foregroundColor(.white)
                        .padding(.horizontal)

                    Text("New Release")
                        .font(.headline)
                        .foregroundStyle(.secondary)
                        .padding(.horizontal)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(topPicks) { item in
                                NavigationLink {
                                    MixDetailView(mix: item)
                                } label: {
                                    AnimatedMusicCard(
                                        title: item.title,
                                        subtitle: "Mix",
                                        footnote: item.subtitle,
                                        colors: palette(for: item.artworkColor),
                                        prominentColor: item.artworkColor,
                                        width: 300,
                                        height: 300,
                                        cornerRadius: 26,
                                        style: .blobs
                                    )
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(.vertical, 4)
                        .padding(.horizontal)
                    }
                }

                // MARK: Horizontal rows
                HorizontalRow(title: "Recently Played", items: recentlyPlayed) { item in
                    player.play(item: item)
                }
                HorizontalRow(title: "2000s", items: twoThousands) { item in
                    player.play(item: item)
                }

                // MARK: Made for You – BIG wide cards (Replay-style)
                MadeForYouRow(items: madeForYou) { item in
                    player.play(item: item)
                }

                HorizontalRow(title: "Workout", items: workout) { item in
                    player.play(item: item)
                }
                HorizontalRow(title: "Chill", items: chill) { item in
                    player.play(item: item)
                }
                HorizontalRow(title: "Jazz", items: jazz) { item in
                    player.play(item: item)
                }
                HorizontalRow(title: "Pop", items: pop) { item in
                    player.play(item: item)
                }
                HorizontalRow(title: "Metal", items: metal) { item in
                    player.play(item: item)
                }

                Spacer(minLength: 44)
            }
        }
        .background(Color.black.ignoresSafeArea())
        .sheet(isPresented: $showAccount) {
            AccountSheetView()
                .presentationDetents([.large])
                .presentationDragIndicator(.visible)
                .presentationCornerRadius(32)
                .presentationBackground(.clear)
        }
    }

    // MARK: - Gradient palette for animated cards

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

// MARK: - BIG Made For You row (Replay-style cards)

private struct MadeForYouRow: View {
    let items: [MusicItem]
    let onTap: (MusicItem) -> Void

    // Card size similar to Apple Music Replay
    private var cardWidth: CGFloat {
        UIScreen.main.bounds.width - 48   // nice side padding
    }
    private let cardHeight: CGFloat = 260

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Made for You")
                .font(.title2.bold())
                .foregroundColor(.white)
                .padding(.horizontal)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(items) { item in
                        Button {
                            onTap(item)
                        } label: {
                            ZStack(alignment: .bottomLeading) {
                                // Background block
                                RoundedRectangle(cornerRadius: 22, style: .continuous)
                                    .fill(item.artworkColor)
                                    .frame(width: cardWidth, height: cardHeight)
                                    .overlay(
                                        // slight vertical gradient for depth / legibility
                                        LinearGradient(
                                            colors: [
                                                Color.black.opacity(0.0),
                                                Color.black.opacity(0.15),
                                                Color.black.opacity(0.35)
                                            ],
                                            startPoint: .top,
                                            endPoint: .bottom
                                        )
                                    )

                                VStack(alignment: .leading, spacing: 4) {
                                    Text(item.title)
                                        .font(.title.bold())
                                        .foregroundColor(.white)
                                        .lineLimit(1)

                                    Text(item.subtitle)
                                        .font(.headline)
                                        .foregroundColor(.white.opacity(0.9))
                                        .lineLimit(1)
                                }
                                .padding(.horizontal, 18)
                                .padding(.bottom, 16)
                            }
                        }
                        .buttonStyle(.plain)
                        .shadow(color: .black.opacity(0.35), radius: 18, x: 0, y: 8)
                    }
                }
                .padding(.vertical, 6)
                .padding(.horizontal)
            }
        }
    }
}

// MARK: - Reusable horizontal row

private struct HorizontalRow: View {
    let title: String
    let items: [MusicItem]
    let onTap: (MusicItem) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.title2.bold())
                .foregroundColor(.white)
                .padding(.horizontal)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(items) { item in
                        SquareAlbumItemView(item: item) {
                            onTap(item)
                        }
                    }
                }
                .padding(.vertical, 4)
                .padding(.horizontal)
            }
        }
    }
}

// MARK: - Square album card

struct SquareAlbumItemView: View {
    let item: MusicItem
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            VStack(alignment: .leading, spacing: 6) {
                RoundedRectangle(cornerRadius: 14)
                    .fill(item.artworkColor)
                    .frame(width: 140, height: 140)

                Text(item.title)
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .lineLimit(1)

                Text(item.subtitle)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
            }
            .frame(width: 140, alignment: .leading)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    NavigationStack {
        HomeView()
            .environmentObject(PlayerStore())
    }
    .preferredColorScheme(.dark)
}
