import SwiftUI

@main
struct ScoreboardApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject private var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
                .preferredColorScheme(.dark)
        }
    }
}

/// Root view that switches between screens based on AppState
struct ContentView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        ZStack {
            switch appState.currentScreen {
            case .mainMenu:
                MainMenuView()
                    .transition(.opacity)
            case .settings:
                SettingsView()
                    .transition(.move(edge: .trailing))
            case .teamSelection:
                TeamSelectionView()
                    .transition(.move(edge: .trailing))
            case .scoreboard:
                ScoreboardView()
                    .transition(.move(edge: .trailing))
            case .scoreHistory:
                ScoreHistoryView()
                    .transition(.move(edge: .trailing))
            }
        }
        .animation(.easeInOut(duration: 0.3), value: appState.currentScreen)
    }
}
