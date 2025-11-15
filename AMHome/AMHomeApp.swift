import SwiftUI

@main
struct AMHomeApp: App {
    @StateObject private var player = PlayerStore()

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                HomeView()
            }
            .environmentObject(player)
            .preferredColorScheme(.dark)
        }
    }
}
