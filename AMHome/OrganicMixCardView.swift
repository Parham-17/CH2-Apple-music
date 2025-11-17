import SwiftUI

struct OrganicMixCardView: View {
    let item: MusicItem

    var width: CGFloat = 260
    var height: CGFloat = 320

    @State private var animate = false

    // MARK: - Color palette based on artworkColor
    private var palette: [Color] {
        Self.palette(for: item.artworkColor)
    }

    private func c(_ index: Int) -> Color {
        guard palette.indices.contains(index) else { return palette.first ?? .pink }
        return palette[index]
    }

    var body: some View {
        ZStack {
            // MARK: - Background shapes and animations

            Circle()
                .fill(c(0))
                .blur(radius: 10)
                .offset(x: animate ? 10 : 130, y: animate ? 20 : 160)
                .rotation3DEffect(
                    .degrees(animate ? 30 : 0),
                    axis: (x: animate ? 0 : 0.5,
                           y: animate ? 0.2 : 0.9,
                           z: animate ? 0.4 : 0)
                )

            RoundedRectangle(cornerRadius: 10)
                .fill(c(1))
                .blur(radius: 20)
                .offset(x: animate ? -120 : 10, y: animate ? -100 : 20)
                .rotation3DEffect(
                    .degrees(animate ? 80 : 20),
                    axis: (x: animate ? 0.4 : 0,
                           y: animate ? 0 : 0.1,
                           z: animate ? 0 : 0.5)
                )

            Rectangle()
                .fill(c(2))
                .blur(radius: 30)
                .offset(x: animate ? -60 : 20, y: animate ? 5 : 140)
                .rotation3DEffect(
                    .degrees(animate ? 20 : 50),
                    axis: (x: animate ? 0 : 0,
                           y: animate ? 0.4 : 0.2,
                           z: animate ? 0.9 : 0.3)
                )

            Capsule()
                .fill(c(3))
                .blur(radius: 40)
                .offset(x: animate ? 60 : 0, y: animate ? 0 : 140)
                .rotation3DEffect(
                    .degrees(animate ? -30 : 0),
                    axis: (x: animate ? 0.6 : 0.1,
                           y: animate ? 0.2 : 0.3,
                           z: animate ? 0.1 : 0.9)
                )

            Circle()
                .fill(c(4))
                .blur(radius: 20)
                .offset(x: animate ? 90 : -10, y: animate ? -90 : 40)
                .rotation3DEffect(
                    .degrees(animate ? 10 : 0),
                    axis: (x: animate ? 0.2 : 0.6,
                           y: animate ? 0.1 : 0,
                           z: animate ? 0.6 : 0.4)
                )

            RoundedRectangle(cornerRadius: 10)
                .fill(c(5))
                .blur(radius: 20)
                .offset(x: animate ? -60 : 40, y: animate ? 90 : -20)
                .rotation3DEffect(
                    .degrees(animate ? -20 : 10),
                    axis: (x: animate ? 0 : 0.2,
                           y: animate ? 0 : 0,
                           z: animate ? 0.4 : 0)
                )

            Capsule()
                .fill(c(6).opacity(0.8))
                .blur(radius: 60)
                .offset(x: animate ? 10 : 170, y: animate ? 0 : -150)
                .opacity(0.4)
                .rotation3DEffect(
                    .degrees(animate ? 30 : 0),
                    axis: (x: animate ? 0 : 0.1,
                           y: animate ? 0.5 : 0.1,
                           z: animate ? 0.2 : 0.6)
                )

            // MARK: - Foreground content

            VStack {
                HStack {
                    VStack(alignment: .leading, spacing: 25) {
                        HStack(spacing: 4) {
                            Image(systemName: "applelogo")
                                .font(.title3)
                            Text("Music")
                                .font(.title3.weight(.semibold))
                        }

                        Text(item.title)
                            .font(.system(size: 32, weight: .heavy))
                            .tracking(0.5)

                        Text("Replay")
                            .font(.system(size: 44, weight: .bold, design: .rounded))
                            .kerning(-3)
                            .padding(.top, 20)
                    }

                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)

                Spacer()

                Text(item.subtitle)
                    .font(.system(size: 18))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 26)
                    .frame(maxWidth: .infinity)
                    .background(.ultraThinMaterial)
                    .multilineTextAlignment(.center)
                    .clipShape(RoundedRectangle(cornerRadius: 1, style: .continuous))
                    .padding(.horizontal, 0)
                    .padding(.bottom, 0)
            }
            .foregroundColor(.white)
        }
        .frame(width: width, height: height)
        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
        .shadow(color: Color.black.opacity(0.25), radius: 25, x: 0, y: 20)
        .onAppear {
            withAnimation(.easeInOut(duration: 5).repeatForever(autoreverses: true)) {
                animate.toggle()
            }
        }
    }

    // MARK: - Palette generator

    private static func palette(for color: Color) -> [Color] {
        switch color {
        case .pink:
            return [.pink, .purple, .orange, .red, .yellow, .pink.opacity(0.7), .purple.opacity(0.8)]
        case .purple:
            return [.purple, .indigo, .blue, .mint, .teal, .purple.opacity(0.7), .blue.opacity(0.8)]
        case .orange:
            return [.orange, .red, .yellow, .pink, .orange.opacity(0.7), .yellow.opacity(0.8), .red.opacity(0.8)]
        case .teal:
            return [.teal, .mint, .blue, .cyan, .green, .teal.opacity(0.7), .mint.opacity(0.8)]
        case .yellow:
            return [.yellow, .orange, .pink, .red, .yellow.opacity(0.7), .orange.opacity(0.8), .pink.opacity(0.8)]
        case .blue:
            return [.blue, .indigo, .teal, .mint, .cyan, .blue.opacity(0.7), .indigo.opacity(0.8)]
        default:
            return [
                Color.cyan,
                Color.blue,
                Color.mint,
                Color.teal,
                Color.green,
                Color.cyan.opacity(0.7),
                Color.blue.opacity(0.8)
            ]
        }
    }
}

#Preview {
    OrganicMixCardView(
        item: MusicItem(
            title: "YOOO",
            subtitle: "Imagine Dragons, Adele, Justin Bieber, Dua Lipa…",
            artworkColor: .pink
        )
    )
    .preferredColorScheme(.dark)
}
