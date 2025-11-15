import SwiftUI

struct RootTabView: View {
    var body: some View {
        TabView {
            // MARK: Home
            NavigationStack {
                HomeView()
            }
            .tabItem {
                Image(systemName: "house.fill")
                Text("Home")
            }

            // MARK: New
            NavigationStack {
                NewView()
            }
            .tabItem {
                Image(systemName: "square.grid.2x2.fill")
                Text("New")
            }

            // MARK: Radio
            NavigationStack {
                RadioView()
            }
            .tabItem {
                Image(systemName: "dot.radiowaves.left.and.right")
                Text("Radio")
            }

            // MARK: Library
            NavigationStack {
                LibraryView()
            }
            .tabItem {
                Image(systemName: "music.note.list")
                Text("Library")
            }

            // MARK: Search
            NavigationStack {
                SearchView()
            }
            .tabItem {
                Image(systemName: "magnifyingglass")
                Text("Search")
            }
        }
    }
}

#Preview {
    RootTabView()
        .environmentObject(PlayerStore())
        .preferredColorScheme(.dark)
}
