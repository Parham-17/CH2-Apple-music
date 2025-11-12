import SwiftUI

struct AccountView: View {
    var body: some View {
        NavigationStack {
            List {
                Section("Account") {
                    HStack {
                        ZStack {
                            Circle()
                                .fill(
                                    LinearGradient(colors: [.pink, .orange],
                                                   startPoint: .topLeading,
                                                   endPoint: .bottomTrailing)
                                )
                                .frame(width: 50, height: 50)
                            Text("P")
                                .font(.title2.bold())
                                .foregroundColor(.white)
                        }
                        VStack(alignment: .leading) {
                            Text("Parham")
                                .font(.headline)
                            Text("View Apple ID, Subscriptions, etc.")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                }

                Section("Settings") {
                    Label("Notifications", systemImage: "bell.badge")
                    Label("Playback", systemImage: "play.circle")
                    Label("Content & Privacy", systemImage: "hand.raised")
                }
            }
            .scrollContentBackground(.hidden)
            .background(Color.black)
            .navigationTitle("Account")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    AccountView()
}
