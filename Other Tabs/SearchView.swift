import SwiftUI

struct SearchView: View {
    enum Scope: String, CaseIterable, Identifiable {
        case appleMusic = "Apple Music"
        case library = "Library"
        var id: String { rawValue }
    }

    @State private var scope: Scope = .appleMusic
    @State private var recent: [String] = []

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack(spacing: 24) {
                // ✅ Native iOS 26 segmented control (liquid glass)
                Picker("Scope", selection: $scope) {
                    ForEach(Scope.allCases) { s in
                        Text(s.rawValue).tag(s)
                    }
                }
                .pickerStyle(.segmented)
                .controlSize(.extraLarge)
                .padding(.horizontal)
                .padding(.top, 10)

                Spacer()

                if recent.isEmpty {
                    VStack(spacing: 12) {
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 80))
                            .foregroundStyle(.gray.opacity(0.7))
                            .padding(.bottom, 6)

                        Text("No Recent Searches")
                            .font(.title.bold())
                            .foregroundStyle(.white)

                        Text("Your recent searches will appear here")
                            .font(.title3)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.horizontal, 24)
                } else {
                }

                Spacer()
            }
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}

#Preview {
    SearchView().preferredColorScheme(.dark)
}
