import SwiftUI

struct ScoreboardView: View {
    @EnvironmentObject var appState: AppState
    @State private var showResetAlert = false
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.black.ignoresSafeArea()
                
                VStack(spacing: 0) {
                    topBar
                    
                    HStack(spacing: 2) {
                        ForEach(TeamColor.teams(for: appState.teamCount)) { team in
                            TeamScoreView(
                                team: team,
                                score: appState.scores[team, default: 0],
                                glowEnabled: appState.glowEnabled,
                                onTap: { appState.incrementScore(for: team) }
                            )
                        }
                    }
                }
            }
        }
        .statusBarHidden(true)
        .onAppear {
            OrientationManager.shared.lockLandscape()
        }
        .onDisappear {
            OrientationManager.shared.unlockOrientation()
        }
        .alert("Reset Scores?", isPresented: $showResetAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Reset", role: .destructive) {
                appState.resetScores()
            }
        } message: {
            Text("Current scores will be saved to history.")
        }
    }
    
    var topBar: some View {
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
            
            if appState.timerEnabled {
                HStack(spacing: 16) {
                    Text(appState.timerManager.displayString)
                        .font(.system(size: 28, weight: .bold, design: .monospaced))
                        .foregroundColor(.white)
                    
                    HStack(spacing: 8) {
                        if appState.timerManager.isRunning {
                            Button(action: { appState.timerManager.pause() }) {
                                Image(systemName: "pause.fill")
                                    .foregroundColor(.white)
                                    .padding(8)
                                    .background(.ultraThinMaterial)
                                    .clipShape(Circle())
                            }
                        } else {
                            Button(action: { appState.timerManager.start() }) {
                                Image(systemName: "play.fill")
                                    .foregroundColor(.white)
                                    .padding(8)
                                    .background(.ultraThinMaterial)
                                    .clipShape(Circle())
                            }
                        }
                        
                        Button(action: { appState.timerManager.reset() }) {
                            Image(systemName: "arrow.counterclockwise")
                                .foregroundColor(.white)
                                .padding(8)
                                .background(.ultraThinMaterial)
                                .clipShape(Circle())
                        }
                    }
                }
            }
            
            Spacer()
            
            HStack(spacing: 16) {
                Button(action: {
                    appState.navigate(to: .scoreHistory)
                }) {
                    HStack {
                        Image(systemName: "list.bullet")
                        Text("Scores")
                    }
                    .foregroundColor(.white)
                }
                .buttonStyle(GlassBackButtonStyle())
                
                Button(action: {
                    showResetAlert = true
                }) {
                    HStack {
                        Image(systemName: "arrow.counterclockwise")
                        Text("Reset")
                    }
                    .foregroundColor(.white)
                }
                .buttonStyle(GlassBackButtonStyle())
            }
        }
        .padding(.horizontal)
        .frame(height: 60)
        .background(Color.black.opacity(0.9))
    }
}
