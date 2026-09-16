import SwiftUI

struct MainMenuView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack(spacing: 0) {
                Text("SCOREBOARD")
                    .font(.system(size: 42, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                
                Spacer().frame(height: 40)
                
                Button(action: {
                    appState.navigate(to: .teamSelection)
                }) {
                    Text("START")
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .frame(width: 280)
                }
                .buttonStyle(GlassButtonStyle(isLarge: true))
                
                Spacer().frame(height: 16)
                
                Button(action: {
                    appState.navigate(to: .settings)
                }) {
                    Text("SETTINGS")
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .frame(width: 280)
                }
                .buttonStyle(GlassButtonStyle(isLarge: true))
            }
        }
    }
}
