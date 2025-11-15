import SwiftUI

@main
struct AMHomeApp: App {
    @StateObject private var player = PlayerStore()

    var body: some Scene {
        WindowGroup {
            RootTabView()
                .environmentObject(player)
                .preferredColorScheme(.dark)
        }
    }
}
