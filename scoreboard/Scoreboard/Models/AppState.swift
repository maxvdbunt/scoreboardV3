import SwiftUI

/// Navigation destinations
enum AppScreen: Equatable {
    case mainMenu
    case settings
    case teamSelection
    case scoreboard(teamCount: Int)
    case scoreHistory
}

/// Central app state — injected as @EnvironmentObject
class AppState: ObservableObject {
    // MARK: - Navigation
    @Published var currentScreen: AppScreen = .mainMenu
    
    // MARK: - Settings (persistent via UserDefaults)
    // Using @Published + UserDefaults instead of @AppStorage because
    // @AppStorage doesn't trigger objectWillChange on ObservableObject.
    @Published var timerEnabled: Bool {
        didSet { UserDefaults.standard.set(timerEnabled, forKey: "timerEnabled") }
    }
    @Published var glowEnabled: Bool {
        didSet { UserDefaults.standard.set(glowEnabled, forKey: "glowEnabled") }
    }
    
    // MARK: - Active Game (temporary)
    @Published var teamCount: Int = 2
    @Published var scores: [TeamColor: Int] = [:]
    @Published var timerManager = TimerManager()
    
    // MARK: - Score History (temporary)
    @Published var scoreHistory: [GameResult] = []
    
    init() {
        self.timerEnabled = UserDefaults.standard.bool(forKey: "timerEnabled")
        self.glowEnabled = UserDefaults.standard.bool(forKey: "glowEnabled")
    }
    
    // MARK: - Navigation Methods
    func navigate(to screen: AppScreen) {
        withAnimation(.easeInOut(duration: 0.3)) {
            currentScreen = screen
        }
    }
    
    func goBack() {
        withAnimation(.easeInOut(duration: 0.3)) {
            switch currentScreen {
            case .mainMenu:
                break
            case .settings:
                currentScreen = .mainMenu
            case .teamSelection:
                currentScreen = .mainMenu
            case .scoreboard:
                currentScreen = .teamSelection
            case .scoreHistory:
                currentScreen = .scoreboard(teamCount: teamCount)
            }
        }
    }
    
    // MARK: - Game Methods
    func startGame(teamCount: Int) {
        self.teamCount = teamCount
        scores = [:]
        for team in TeamColor.teams(for: teamCount) {
            scores[team] = 0
        }
        timerManager.reset()
        navigate(to: .scoreboard(teamCount: teamCount))
    }
    
    func incrementScore(for team: TeamColor) {
        scores[team, default: 0] += 1
    }
    
    func resetScores() {
        // Save current scores to history before resetting
        let currentScores = TeamColor.teams(for: teamCount).map { team in
            (team: team, score: scores[team, default: 0])
        }
        
        // Only save if at least one score > 0
        let hasScores = currentScores.contains { $0.score > 0 }
        if hasScores {
            let result = GameResult(
                teamCount: teamCount,
                scores: currentScores,
                timestamp: Date()
            )
            scoreHistory.append(result)
        }
        
        // Reset scores
        for team in TeamColor.teams(for: teamCount) {
            scores[team] = 0
        }
        
        // Reset timer
        timerManager.reset()
    }
}
