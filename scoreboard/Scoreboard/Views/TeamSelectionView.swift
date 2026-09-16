import SwiftUI

struct TeamSelectionView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack {
                HStack {
                    Button(action: {
                        appState.goBack()
                    }) {
                        HStack {
                            Image(systemName: "chevron.left")
                            Text("Back")
                        }
                        .foregroundColor(.white)
                    }
                    .buttonStyle(GlassBackButtonStyle())
                    
                    Spacer()
                }
                .padding()
                
                Spacer()
                
                Text("SELECT TEAMS")
                    .font(.system(size: 32, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                
                Spacer().frame(height: 40)
                
                Button(action: {
                    appState.startGame(teamCount: 2)
                }) {
                    Text("2 TEAMS")
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .frame(width: 280)
                }
                .buttonStyle(GlassButtonStyle(isLarge: true))
                
                Spacer().frame(height: 16)
                
                Button(action: {
                    appState.startGame(teamCount: 4)
                }) {
                    Text("4 TEAMS")
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .frame(width: 280)
                }
                .buttonStyle(GlassButtonStyle(isLarge: true))
                
                Spacer()
            }
        }
    }
}
