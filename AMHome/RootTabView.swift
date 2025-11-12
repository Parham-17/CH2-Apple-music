import SwiftUI

struct RootTabView: View {

    @EnvironmentObject private var player: PlayerStore
    @State private var searchText: String = ""

    var body: some View {
        TabView {
            // Home
            Tab("Home", systemImage: "house.fill") {
                HomeView()
            }

            // New
            Tab("New", systemImage: "square.grid.2x2.fill") {
                NewView()
            }

            // Radio
            Tab("Radio", systemImage: "dot.radiowaves.left.and.right") {
                RadioView()
            }

            // Library
            Tab("Library", systemImage: "music.note.list") {
                LibraryView()
            }

            // Search — system renders as separated search item
            Tab(role: .search) {
                NavigationStack {
                    SearchView()
                        .navigationTitle("Search")
                }
            }
        }
        .preferredColorScheme(.dark)

        .searchable(text: $searchText)
        .tabBarMinimizeBehavior(.onScrollDown)

        // Native bottom accessory: mini player
        .tabViewBottomAccessory {
            if let now = player.nowPlaying {
                MiniPlayerView(nowPlaying: now)
                    .environmentObject(player)
                    .padding(.horizontal, 12)
                    .padding(.bottom, 4)
//                    .environment(\.colorScheme, .dark)

            }
        }

        .background(Color.black.ignoresSafeArea())
    }
}

#Preview {
    RootTabView()
        .environmentObject(PlayerStore())
}
