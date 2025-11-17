import SwiftUI

struct AccountSheetView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ZStack {
                Color(uiColor: .secondarySystemBackground)
                    .opacity(0.35)
                    .ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 28) {

                        // MARK: Profile row
                        GlassGroup {
                            HStack(spacing: 14) {
                                Image(systemName: "person.crop.circle.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 44, height: 44)
                                    .foregroundStyle(.white)
                                    .background(
                                        Circle().fill(.ultraThinMaterial)
                                    )

                                Text("Parham Karbasi")
                                    .font(.headline.weight(.semibold))
                                    .foregroundStyle(.white)

                                Spacer()

                                Text("Edit")
                                    .font(.headline)
                                    .foregroundStyle(.red)
                            }
                            .padding(14)
                        }

                        // MARK: Set up Profile info
                        VStack(alignment: .leading, spacing: 8) {
                            GlassGroup {
                                HStack {
                                    Text("Set up Profile")
                                        .font(.headline.weight(.semibold))
                                        .foregroundStyle(.red)
                                    Spacer()
                                }
                                .padding(16)
                            }

                            Text("Set up your profile to share your music and see what your friends are playing.")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                                .padding(.horizontal, 4)
                        }

                        // MARK: Gift / funds / subscription / family
                        GlassList {
                            AccountRow(title: "Redeem Gift Card or Code")
                            AccountDivider()
                            AccountRow(title: "Add Funds to Apple Account")
                            AccountDivider()
                            AccountRow(title: "Manage Subscription")
                            AccountDivider()
                            AccountRow(title: "Add Family Members")
                        }

                        // MARK: Notifications
                        GlassGroup {
                            HStack {
                                Text("Notifications")
                                    .font(.headline.weight(.semibold))
                                    .foregroundStyle(.white)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundStyle(.secondary)
                            }
                            .padding(16)
                        }

                        // MARK: Example toggle row
                        GlassGroup {
                            HStack {
                                VStack(alignment: .leading, spacing: 6) {
                                    Text("Contacts on Apple Music")
                                        .font(.headline.weight(.semibold))
                                        .foregroundStyle(.white)
                                }
                                Spacer()
                                Toggle("", isOn: .constant(true))
                                    .labelsHidden()
                            }
                            .padding(16)
                        }

                        Spacer(minLength: 32)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 16)
                    .padding(.bottom, 24)
                }
            }
            // MARK: Navigation / toolbar (Liquid Glass X button)
            .navigationTitle("Account")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(role: .cancel) {
                        dismiss()
                    } label: {
                        Label("Close", systemImage: "xmark")
                    }
                }
            }
        }
    }
}

// MARK: - Helpers

private struct GlassGroup<Content: View>: View {
    @ViewBuilder var content: Content

    var body: some View {
        content
            .background(
                .thinMaterial,
                in: RoundedRectangle(cornerRadius: 24, style: .continuous)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 24, style: .continuous)
                    .strokeBorder(.white.opacity(0.08), lineWidth: 1)
            )
    }
}

private struct GlassList<Content: View>: View {
    @ViewBuilder var content: Content

    var body: some View {
        VStack(spacing: 0) {
            content
        }
        .background(
            .thinMaterial,
            in: RoundedRectangle(cornerRadius: 24, style: .continuous)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .strokeBorder(.white.opacity(0.08), lineWidth: 1)
        )
    }
}

private struct AccountRow: View {
    let title: String

    var body: some View {
        HStack {
            Text(title)
                .font(.headline.weight(.semibold))
                .foregroundStyle(.red)
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
    }
}

private struct AccountDivider: View {
    var body: some View {
        Rectangle()
            .fill(.white.opacity(0.08))
            .frame(height: 1)
            .padding(.horizontal, 16)
    }
}

#Preview {
    AccountSheetView()
        .preferredColorScheme(.dark)
}
