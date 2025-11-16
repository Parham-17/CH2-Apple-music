import SwiftUI

// MARK: - Public API

public enum CardAnimationStyle: String, CaseIterable {
    case blobs, beams, waves, swirl, sparkles, staticGradient
}

public struct AnimatedMusicCard: View {
    public let title: String
    public let subtitle: String
    public let footnote: String
    public let colors: [Color]
    public let prominentColor: Color
    public var width: CGFloat = 260
    public var height: CGFloat = 320
    public var cornerRadius: CGFloat = 26
    public var style: CardAnimationStyle = .blobs
    public var speed: Double = 0.35      // global motion speed
    public var intensity: Double = 1.0   // style-specific “amount”

    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    public init(
        title: String,
        subtitle: String,
        footnote: String,
        colors: [Color],
        prominentColor: Color,
        width: CGFloat = 260,
        height: CGFloat = 320,
        cornerRadius: CGFloat = 26,
        style: CardAnimationStyle = .blobs,
        speed: Double = 0.35,
        intensity: Double = 1.0
    ) {
        self.title = title
        self.subtitle = subtitle
        self.footnote = footnote
        self.colors = colors
        self.prominentColor = prominentColor
        self.width = width
        self.height = height
        self.cornerRadius = cornerRadius
        self.style = style
        self.speed = speed
        self.intensity = intensity
    }

    public var body: some View {
        ZStack(alignment: .topLeading) {

            let shape = RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)

            // MARK: - Unified background
            shape
                .fill(Color.black.opacity(0.16))
                .overlay(
                    AnimatedBackground(
                        colors: colors,
                        cornerRadius: cornerRadius,
                        style: style,
                        speed: speed,
                        intensity: intensity,
                        reduceMotion: reduceMotion
                    )
                    .clipShape(shape)
                )
                .overlay(
                    LinearGradient(
                        gradient: Gradient(stops: [
                            .init(color: .clear,                    location: 0.0),
                            .init(color: .clear,                    location: 0.35),
                            .init(color: .black.opacity(0.25),      location: 0.75),
                            .init(color: .black.opacity(0.70),      location: 1.0)
                        ]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .clipShape(shape)
                )
                .overlay(
                    shape
                        .strokeBorder(Color.white.opacity(0.15), lineWidth: 0.8)
                )

            // MARK: - Foreground content
            VStack(alignment: .leading, spacing: 10) {
                HStack(spacing: 8) {
                    Image(systemName: "applelogo")
                        .font(.title3)
                    Text("Music")
                        .font(.title3.weight(.semibold))
                }

                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.system(size: 36, weight: .bold, design: .rounded))
                        .foregroundStyle(.white)
                        .lineLimit(2)

                    Text(subtitle)
                        .font(.title3.weight(.semibold))
                        .foregroundStyle(.white.opacity(0.95))
                        .lineLimit(1)
                }
                .padding(.top, 4)

                Spacer(minLength: 0)

                Text(footnote)
                    .font(.footnote)
                    .foregroundStyle(.white.opacity(0.9))
                    .lineLimit(3)
            }
            .padding(18)
        }
        .frame(width: width, height: height)
        .shadow(color: .black.opacity(0.35), radius: 24, x: 0, y: 12)
    }
}

// MARK: - Animated Background

private struct AnimatedBackground: View {
    let colors: [Color]
    let cornerRadius: CGFloat
    let style: CardAnimationStyle
    let speed: Double
    let intensity: Double
    let reduceMotion: Bool

    var body: some View {
        if reduceMotion || style == .staticGradient {
            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: colors,
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .opacity(0.8)
                )
        } else {
            TimelineView(.animation(minimumInterval: 1.0 / 30.0)) { timeline in
                let t = timeline.date.timeIntervalSinceReferenceDate * max(0.05, speed)

                ZStack {
                    switch style {
                    case .blobs:
                        BlobFieldCanvas(colors: colors, time: t, intensity: intensity)
                    case .beams:
                        BeamsCanvas(colors: colors, time: t, intensity: intensity)
                    case .waves:
                        WavesCanvas(colors: colors, time: t, intensity: intensity)
                    case .swirl:
                        SwirlCanvas(colors: colors, time: t, intensity: intensity)
                    case .sparkles:
                        SparklesCanvas(colors: colors, time: t, intensity: intensity)
                    case .staticGradient:
                        EmptyView()
                    }
                }
                .drawingGroup()
            }
        }
    }
}

// MARK: - Renderers (Canvas)

// Shared gloss overlay
private func gloss(ctx: inout GraphicsContext, size: CGSize) {
    let grad = Gradient(stops: [
        .init(color: .white.opacity(0.18), location: 0.0),
        .init(color: .white.opacity(0.05), location: 0.35),
        .init(color: .clear,             location: 1.0)
    ])
    let shading: GraphicsContext.Shading = .linearGradient(
        grad,
        startPoint: CGPoint(x: 0, y: 0),
        endPoint: CGPoint(x: 0, y: size.height)
    )
    ctx.fill(
        Path(CGRect(x: 0, y: 0, width: size.width, height: size.height)),
        with: shading
    )
}

// 1) Blobs — drifting radial gradients
private struct BlobFieldCanvas: View {
    let colors: [Color]
    let time: Double
    let intensity: Double
    private var blobCount: Int { max(3, Int(5 * intensity)) }

    var body: some View {
        Canvas { ctx, size in
            let base = min(size.width, size.height)

            for i in 0..<blobCount {
                let phase = time + Double(i) * 1.33
                let x = (sin(phase * 0.9) * 0.35 + 0.5) * size.width
                let y = (cos(phase * 1.1) * 0.35 + 0.5) * size.height
                let center = CGPoint(x: x, y: y)

                let radius = base * (0.30 + 0.18 * CGFloat((i % 3) + 1) / 3.0)
                let color = colors.indices.contains(i) ? colors[i] : .purple
                let gradient = Gradient(colors: [color.opacity(0.85), color.opacity(0.35), .clear])
                let shading: GraphicsContext.Shading = .radialGradient(
                    gradient,
                    center: center,
                    startRadius: 4,
                    endRadius: radius
                )
                ctx.fill(
                    Path(ellipseIn: CGRect(
                        x: center.x - radius,
                        y: center.y - radius,
                        width: radius * 2,
                        height: radius * 2
                    )),
                    with: shading
                )
            }

        }
    }
}

// 2) Beams — sweeping linear gradients
private struct BeamsCanvas: View {
    let colors: [Color]
    let time: Double
    let intensity: Double

    var body: some View {
        Canvas { ctx, size in
            let beamCount = max(3, Int(4 * intensity))
            for i in 0..<beamCount {
                let phase = time * 0.6 + Double(i) * 0.8
                let w = size.width * 0.18
                let x = (sin(phase) * 0.6 + 0.5) * (size.width + w) - w * 0.5
                let rect = CGRect(
                    x: x,
                    y: -size.height * 0.1,
                    width: w,
                    height: size.height * 1.2
                )

                let c = colors.indices.contains(i % colors.count)
                    ? colors[i % colors.count]
                    : .white
                let grad = Gradient(colors: [.clear, c.opacity(0.6), .clear])
                let shading: GraphicsContext.Shading = .linearGradient(
                    grad,
                    startPoint: CGPoint(x: rect.minX, y: rect.minY),
                    endPoint: CGPoint(x: rect.maxX, y: rect.maxY)
                )
                ctx.fill(Path(rect), with: shading)
            }

            var mutableCtx = ctx
            gloss(ctx: &mutableCtx, size: size)
        }
    }
}

// 3) Waves — layered sine ribbons
private struct WavesCanvas: View {
    let colors: [Color]
    let time: Double
    let intensity: Double

    var body: some View {
        Canvas { ctx, size in
            let layers = max(3, Int(5 * intensity))
            for i in 0..<layers {
                let amp = size.height * (0.04 + 0.02 * CGFloat(i))
                let freq = 2.0 + Double(i) * 0.6
                let phase = time * (0.8 + Double(i) * 0.15)

                var p = Path()
                p.move(to: CGPoint(x: 0, y: size.height * 0.65))
                let steps = 120
                for s in 0...steps {
                    let x = CGFloat(s) / CGFloat(steps) * size.width
                    let y = size.height * 0.65
                        + sin((Double(s) / 30.0) * freq + phase) * amp
                    p.addLine(to: CGPoint(x: x, y: y))
                }
                p.addLine(to: CGPoint(x: size.width, y: size.height))
                p.addLine(to: CGPoint(x: 0, y: size.height))
                p.closeSubpath()

                let c = colors.indices.contains(i % colors.count)
                    ? colors[i % colors.count]
                    : .blue
                let grad = Gradient(colors: [c.opacity(0.35), c.opacity(0.18), .clear])
                let shading: GraphicsContext.Shading = .linearGradient(
                    grad,
                    startPoint: CGPoint(x: 0, y: size.height * 0.4),
                    endPoint: CGPoint(x: size.width, y: size.height)
                )
                ctx.fill(p, with: shading)
            }

            var mutableCtx = ctx
            gloss(ctx: &mutableCtx, size: size)
        }
    }
}

// 4) Swirl — rotating polar swirl
private struct SwirlCanvas: View {
    let colors: [Color]
    let time: Double
    let intensity: Double

    var body: some View {
        Canvas { ctx, size in
            let center = CGPoint(x: size.width / 2, y: size.height / 2)
            let rings = max(4, Int(6 * intensity))
            let maxR = hypot(size.width, size.height) * 0.6

            for i in 0..<rings {
                let r0 = maxR * CGFloat(i) / CGFloat(rings)
                let r1 = maxR * CGFloat(i + 1) / CGFloat(rings)
                var p = Path()
                let segments = 64
                for s in 0...segments {
                    let t = Double(s) / Double(segments)
                    let angle = t * .pi * 2 + time * 0.4 + Double(i) * 0.35
                    let r = r0 + (r1 - r0) * CGFloat(t)
                    let x = center.x + cos(angle) * r
                    let y = center.y + sin(angle) * r
                    if s == 0 { p.move(to: CGPoint(x: x, y: y)) }
                    else { p.addLine(to: CGPoint(x: x, y: y)) }
                }
                p.closeSubpath()

                let c = colors.indices.contains(i % colors.count) ? colors[i % colors.count] : .purple
                let grad = Gradient(colors: [c.opacity(0.35), c.opacity(0.12), .clear])
                let shading: GraphicsContext.Shading = .radialGradient(
                    grad,
                    center: center,
                    startRadius: r0,
                    endRadius: r1
                )
                ctx.fill(p, with: shading)
            }

            var mutableCtx = ctx
            gloss(ctx: &mutableCtx, size: size)
        }
    }
}

// 5) Sparkles — drifting bokeh dots
private struct SparklesCanvas: View {
    let colors: [Color]
    let time: Double
    let intensity: Double

    var body: some View {
        Canvas { ctx, size in
            let count = max(30, Int(60 * intensity))
            let base = min(size.width, size.height)
            for i in 0..<count {
                let seed = Double(i)
                let phase = time * (0.6 + (seed.truncatingRemainder(dividingBy: 7.0)) * 0.05)
                let x = (sin(phase + seed * 0.37) * 0.45 + 0.5) * size.width
                let y = (cos(phase * 1.1 + seed * 0.22) * 0.45 + 0.5) * size.height
                let r = base * (0.006 + 0.012 * CGFloat((i % 5) + 1) / 5.0)

                let c = colors.indices.contains(i % colors.count) ? colors[i % colors.count] : .white
                let grad = Gradient(colors: [c.opacity(0.9), c.opacity(0.35), .clear])
                let shading: GraphicsContext.Shading = .radialGradient(
                    grad,
                    center: CGPoint(x: x, y: y),
                    startRadius: 0,
                    endRadius: r * 3.0
                )
                ctx.fill(
                    Path(ellipseIn: CGRect(x: x - r, y: y - r, width: r * 2, height: r * 2)),
                    with: shading
                )
            }

            var mutableCtx = ctx
            gloss(ctx: &mutableCtx, size: size)
        }
    }
}

// MARK: - Preview

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()

        AnimatedMusicCard(
            title: "SHISH",
            subtitle: "Mix",
            footnote: "Portugal. The Man – 7 November",
            colors: [.orange, .red, .purple, .pink],
            prominentColor: .pink,
            width: 260,
            height: 320,
            cornerRadius: 40,
            style: .blobs,
            speed: 0.35,
            intensity: 1.0
        )
        .padding()
    }
    .preferredColorScheme(.dark)
}
