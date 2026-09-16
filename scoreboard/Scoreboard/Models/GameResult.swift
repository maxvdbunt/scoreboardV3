import Foundation

/// A saved game result from a completed/reset game
struct GameResult: Identifiable {
    let id = UUID()
    let teamCount: Int
    let scores: [(team: TeamColor, score: Int)]
    let timestamp: Date
    
    /// Formatted time string for display
    var timeString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter.string(from: timestamp)
    }
}
