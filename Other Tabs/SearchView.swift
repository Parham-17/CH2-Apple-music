import SwiftUI

struct SearchView: View {

    @State private var query: String = ""

    var body: some View {
        NavigationStack {
            VStack {
                TextField("Artists, Songs, Lyrics, Playlists", text: $query)
                    .textFieldStyle(.roundedBorder)
                    .padding()

                Spacer()

                Text("Search results will appear here.")
                    .foregroundStyle(.secondary)

                Spacer()
            }
            .background(Color.black.ignoresSafeArea())
            .navigationTitle("Search")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        // Dismiss handled by sheet presenter
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
                }
            }
        }
    }
}

#Preview {
    SearchView()
}
