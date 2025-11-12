import SwiftUI

struct RecentlyPlayedListView: View {

    let items: [MusicItem]
    @EnvironmentObject private var player: PlayerStore

    var body: some View {
        List {
            ForEach(items) { item in
                Button {
                    player.play(item: item)
                } label: {
                    HStack(spacing: 12) {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(item.artworkColor)
                            .frame(width: 46, height: 46)
                        VStack(alignment: .leading) {
                            Text(item.title)
                                .font(.body)
                            Text(item.subtitle)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        Spacer()
                    }
                }
                .buttonStyle(.plain)
            }
        }
        .scrollContentBackground(.hidden)
        .background(Color.black)
        .navigationTitle("Recently Played")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        RecentlyPlayedListView(items: [
            MusicItem(title: "Radioactive", subtitle: "Imagine Dragons", artworkColor: .purple)
        ])
        .environmentObject(PlayerStore())
    }
}
