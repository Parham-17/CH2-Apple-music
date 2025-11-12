import SwiftUI

struct HomeView: View {

    @EnvironmentObject private var player: PlayerStore

    private let topPicks: [MusicItem] = [
        MusicItem(title: "SHISH",            subtitle: "Portugal. The Man – 7 November", artworkColor: .red),
        MusicItem(title: "Parham Mix",       subtitle: "Made for You",                   artworkColor: .pink),
        MusicItem(title: "Late Night Vibes", subtitle: "Playlist",                       artworkColor: .blue)
    ]

    private let recentlyPlayed: [MusicItem] = [
        MusicItem(title: "Energy",           subtitle: "Radio Station",        artworkColor: .green),
        MusicItem(title: "Feel Good",        subtitle: "Radio Station",        artworkColor: .yellow),
        MusicItem(title: "Parham Radio",     subtitle: "Radio Station",        artworkColor: .orange),
        MusicItem(title: "Chill Beats",      subtitle: "Playlist",             artworkColor: .purple)
    ]

    private let twoThousands: [MusicItem] = [
        MusicItem(title: "Leaving Eden",         subtitle: "Antimatter",        artworkColor: .blue),
        MusicItem(title: "Late Goodbye - EP",    subtitle: "Poets of the Fall", artworkColor: .brown),
        MusicItem(title: "Don’t Panic",          subtitle: "Coldplay",          artworkColor: .teal),
        MusicItem(title: "Hybrid Theory",        subtitle: "Linkin Park",       artworkColor: .gray),
        MusicItem(title: "American Idiot",       subtitle: "Green Day",         artworkColor: .green),
        MusicItem(title: "Songs About Jane",     subtitle: "Maroon 5",          artworkColor: .red)
    ]

    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 24) {

                    // Home header
                    HStack {
                        Text("Home")
                            .font(.system(size: 34, weight: .bold))
                            .foregroundColor(.white)
                        Spacer()
                        NavigationLink {
                            AccountView()
                        } label: {
                            ZStack {
                                Circle()
                                    .fill(
                                        LinearGradient(colors: [.pink, .orange],
                                                       startPoint: .topLeading,
                                                       endPoint: .bottomTrailing)
                                    )
                                    .frame(width: 36, height: 36)
                                Text("P")
                                    .font(.headline.bold())
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 12)

                    // Top Picks for You
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Top Picks for You")
                            .font(.title2.bold())
                            .foregroundColor(.white)

                        Text("New Release")
                            .font(.headline)
                            .foregroundStyle(.secondary)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(topPicks) { item in
                                    TopPickCard(item: item) {
                                        player.play(item: item)
                                    }
                                }
                            }
                            .padding(.vertical, 4)
                            .padding(.horizontal)
                        }
                    }

                    // Recently Played
                    VStack(alignment: .leading, spacing: 8) {
                        NavigationLink {
                            RecentlyPlayedListView(items: recentlyPlayed)
                        } label: {
                            HStack {
                                Text("Recently Played")
                                    .font(.title2.bold())
                                    .foregroundColor(.white)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }
                        }
                        .buttonStyle(.plain)
                        .padding(.horizontal)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(recentlyPlayed) { item in
                                    SquareAlbumItemView(item: item) {
                                        player.play(item: item)
                                    }
                                }
                            }
                            .padding(.vertical, 4)
                            .padding(.horizontal)
                        }
                    }

                    // 2000s — same style as Recently Played
                    VStack(alignment: .leading, spacing: 8) {
                        Text("2000s")
                            .font(.title2.bold())
                            .foregroundColor(.white)
                            .padding(.horizontal)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(twoThousands) { item in
                                    SquareAlbumItemView(item: item) {
                                        player.play(item: item)
                                    }
                                }
                            }
                            .padding(.vertical, 4)
                            .padding(.horizontal)
                        }
                    }

                    Spacer(minLength: 40)
                }
            }
            .background(Color.black.ignoresSafeArea())
        }
    }
}

// MARK: - Card Components

struct TopPickCard: View {
    let item: MusicItem
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            VStack(alignment: .leading, spacing: 6) {
                RoundedRectangle(cornerRadius: 18)
                    .fill(item.artworkColor)
                    .frame(width: 260, height: 260)
                    .overlay(
                        Text(item.title)
                            .font(.system(size: 32, weight: .heavy, design: .rounded))
                            .multilineTextAlignment(.center)
                            .padding()
                    )

                Text(item.title)
                    .font(.headline)
                    .foregroundColor(.white)
                    .lineLimit(1)

                Text(item.subtitle)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
            }
            .frame(width: 260, alignment: .leading)
        }
        .buttonStyle(.plain)
    }
}

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
    HomeView()
        .environmentObject(PlayerStore())
}
