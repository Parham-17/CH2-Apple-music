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

    private let replay: [MusicItem] = [
        MusicItem(title: "All Time",      subtitle: "Dorcci , Future , Antimatter , A$AP Rocky , Travis Scott and more", artworkColor: .pink),
        MusicItem(title: "'24",           subtitle: "Blackfield , Coldplay , Linkin Park , Maroon 5 and more",          artworkColor: .purple),
        MusicItem(title: "'23",           subtitle: "Leprous , Tamino , Khalid , Billie Eilish , Halsey and more",      artworkColor: .orange),
        MusicItem(title: "'22",           subtitle: "Post Malone , Lord Huron , The Weeknd , Angus & Julia Stone and more", artworkColor: .teal),
        MusicItem(title: "'21",           subtitle: "Slipknot , Cranberries , Poobon , Gunna, UFO , Offset and more",   artworkColor: .yellow)
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

                // MARK: Top Picks – animated cards (mixed styles)
                VStack(alignment: .leading, spacing: 8) {
                    Text("Top Picks for You")
                        .font(.title2.bold())
                        .foregroundColor(.white)
                        .padding(.horizontal)

                    Text("Made for You")
                        .font(.headline)
                        .foregroundStyle(.secondary)
                        .padding(.horizontal)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(Array(topPicks.enumerated()), id: \.offset) { index, item in
                                // 🔹 Choose style based on index: blobs / waves / sparkles
                                let style: CardAnimationStyle = {
                                    switch index % 3 {
                                    case 0: return .blobs
                                    case 1: return .waves
                                    default: return .sparkles
                                    }
                                }()

                                NavigationLink {
                                    MixDetailView(mix: item)
                                } label: {
                                    AnimatedMusicCard(
                                        title: item.title,
                                        subtitle: "",
                                        footnote: item.subtitle,
                                        colors: palette(for: item.artworkColor),
                                        prominentColor: item.artworkColor,
                                        style: style,
                                        speed: 0.35,
                                        intensity: 1.0
                                    )
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(.vertical, 4)
                        .padding(.horizontal)
                    }
                }

                // MARK: Horizontal rows (small square cards)
                HorizontalRow(title: "Recently Played", items: recentlyPlayed) { item in
                    player.play(item: item)
                }

                HorizontalRow(title: "2000s", items: twoThousands) { item in
                    player.play(item: item)
                }

                // MARK: Replay – OrganicMixCardView
                VStack(alignment: .leading, spacing: 8) {
                    Text("Replay: Your Top Music")
                        .font(.title2.bold())
                        .foregroundColor(.white)
                        .padding(.horizontal)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(replay) { item in
                                NavigationLink {
                                    MixDetailView(mix: item)
                                } label: {
                                    OrganicMixCardView(item: item)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(.vertical, 4)
                        .padding(.horizontal)
                    }
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
