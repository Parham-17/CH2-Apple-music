import SwiftUI

@main
struct AMHomeApp: App {

    @StateObject private var playerStore = PlayerStore()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(playerStore)
                .preferredColorScheme(.dark)
        }
    }
}
