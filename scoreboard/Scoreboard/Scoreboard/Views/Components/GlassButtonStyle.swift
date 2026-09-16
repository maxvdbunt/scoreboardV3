import SwiftUI

/// Liquid Glass Capsule Button Style inspired by Apple's VisionOS / iOS 18 Control Center
struct GlassButtonStyle: ButtonStyle {
    var isLarge: Bool = false
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            // Ultra-Clear Refractive Glass Body
            Capsule()
                .fill(
                    LinearGradient(
                        colors: [
                            Color.white.opacity(0.24),
                            Color.white.opacity(0.08),
                            Color(red: 0.75, green: 0.88, blue: 1.0).opacity(0.18)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .background(.ultraThinMaterial)
            
            // Curved Specular Meniscus Glare (Top half)
            GeometryReader { geo in
                VStack {
                    LinearGradient(
                        colors: [
                            Color.white.opacity(0.72),
                            Color.white.opacity(0.20),
                            Color.white.opacity(0.0)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .frame(height: geo.size.height * 0.48)
                    .clipShape(Capsule())
                    Spacer()
                }
            }
            
            // Chromatic Prismatic Rainbow Edge Rim
            Capsule()
                .stroke(
                    LinearGradient(
                        colors: [
                            Color.white.opacity(0.95),                     // Razor-sharp top white rim
                            Color(red: 1.0, green: 0.6, blue: 0.7).opacity(0.4),  // Peach/pink chromatic edge
                            Color(red: 0.4, green: 0.8, blue: 1.0).opacity(0.65)  // Cyan/blue chromatic bottom rim
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    ),
                    lineWidth: 1.2
                )
            
            configuration.label
                .shadow(color: .black.opacity(0.35), radius: 3, x: 0, y: 1)
        }
        .frame(minHeight: isLarge ? 72 : 56)
        .clipShape(Capsule())
        .shadow(color: .black.opacity(0.4), radius: 20, x: 0, y: 12)
        .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
        .opacity(configuration.isPressed ? 0.9 : 1.0)
        .animation(.spring(response: 0.25, dampingFraction: 0.65), value: configuration.isPressed)
    }
}

/// Circular Liquid Glass Orb Button Style (For Back, Reset, Scores)
struct GlassOrbButtonStyle: ButtonStyle {
    var size: CGFloat = 52
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            Circle()
                .fill(
                    LinearGradient(
                        colors: [
                            Color.white.opacity(0.28),
                            Color.white.opacity(0.08),
                            Color(red: 0.75, green: 0.88, blue: 1.0).opacity(0.20)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .background(.ultraThinMaterial)
            
            Circle()
                .stroke(
                    LinearGradient(
                        colors: [
                            Color.white.opacity(0.95),
                            Color(red: 0.4, green: 0.85, blue: 1.0).opacity(0.65)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    ),
                    lineWidth: 1.2
                )
            
            configuration.label
                .foregroundColor(.white)
                .shadow(color: .black.opacity(0.4), radius: 2, x: 0, y: 1)
        }
        .frame(width: size, height: size)
        .clipShape(Circle())
        .shadow(color: .black.opacity(0.35), radius: 14, x: 0, y: 8)
        .scaleEffect(configuration.isPressed ? 0.92 : 1.0)
        .opacity(configuration.isPressed ? 0.9 : 1.0)
        .animation(.spring(response: 0.22, dampingFraction: 0.7), value: configuration.isPressed)
    }
}

/// Back button compatibility alias
typealias GlassBackButtonStyle = GlassOrbButtonStyle
