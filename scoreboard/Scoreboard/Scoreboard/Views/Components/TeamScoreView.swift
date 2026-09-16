import SwiftUI

struct TeamScoreView: View {
    let team: TeamColor
    let score: Int
    let glowEnabled: Bool
    let onTap: () -> Void
    
    @State private var animationScale: CGFloat = 1.0
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                team.color
                    .ignoresSafeArea()
                
                VStack {
                    Text(team.displayName)
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .foregroundColor(.white.opacity(0.9))
                        .padding(.top, 24)
                    
                    Spacer()
                    
                    let fontSize = min(geometry.size.width, geometry.size.height) * 0.4
                    Text("\(score)")
                        .font(.system(size: fontSize, weight: .heavy, design: .rounded))
                        .foregroundColor(.white)
                        .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 2)
                        .shadow(color: glowEnabled ? team.glowColor : .clear, radius: 30, x: 0, y: 0)
                        .scaleEffect(animationScale)
                        .onChange(of: score) { oldValue, newValue in
                            withAnimation(.spring(response: 0.2, dampingFraction: 0.5)) {
                                animationScale = 1.15
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                                withAnimation(.spring(response: 0.2, dampingFraction: 0.5)) {
                                    animationScale = 1.0
                                }
                            }
                        }
                    
                    Spacer()
                    
                    Text("+1")
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                        .foregroundColor(.white.opacity(0.5))
                        .padding(.bottom, 24)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .contentShape(Rectangle())
            .onTapGesture {
                onTap()
            }
        }
    }
}
