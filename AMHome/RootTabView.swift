import SwiftUI

struct RootTabView: View {
    @EnvironmentObject private var player: PlayerStore
    @State private var searchText: String = ""

    var body: some View {
        TabView {

            // MARK: Home
            Tab("Home", systemImage: "house.fill") {
                NavigationStack {
                    HomeView()
                }
            }

            // MARK: New
            Tab("New", systemImage: "square.grid.2x2.fill") {
                NavigationStack {
                    NewView()
                }
            }

            // MARK: Radio
            Tab("Radio", systemImage: "dot.radiowaves.left.and.right") {
                NavigationStack {
                    RadioView()
                }
            }

            // MARK: Library
            Tab("Library", systemImage: "music.note.list") {
                NavigationStack {
                    LibraryView()
                }
            }

            // MARK: Search tab – **no custom label**
            Tab(role: .search) {
                NavigationStack {
                    SearchView()
                        .navigationTitle("Search")
                }
            }
        }
        // 🔍 Global search configuration for the tab bar
        .searchable(
            text: $searchText,
            placement: .automatic,
            prompt: "Apple Music"
        )
        .searchToolbarBehavior(.minimize)

        // 🎵 Mini player above the tab bar
        .tabViewBottomAccessory {
            MiniPlayerBar()
        }

        // Collapses tab bar + accessory on scroll
        .tabBarMinimizeBehavior(.onScrollDown)
        .onAppear {
            if player.nowPlaying == nil {
                player.nowPlaying = MusicItem(
                    title: "Radioactive",
                    subtitle: "Imagine Dragons",
                    artworkColor: .purple
                )
                player.isPlaying = true
            }
        }
    }
}

#Preview {
    RootTabView()
        .environmentObject({
            let store = PlayerStore()
            store.nowPlaying = MusicItem(
                title: "Radioactive",
                subtitle: "Imagine Dragons",
                artworkColor: .purple
            )
            store.isPlaying = true
            return store
        }())
        .preferredColorScheme(.dark)
        .tint(.red)
}
