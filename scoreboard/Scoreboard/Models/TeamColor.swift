import SwiftUI

/// Represents a team with its display color and name
enum TeamColor: String, CaseIterable, Identifiable, Codable {
    case blue, red, green, yellow
    
    var id: String { rawValue }
    
    var color: Color {
        switch self {
        case .blue: return Color(red: 0.1, green: 0.3, blue: 0.9)
        case .red: return Color(red: 0.9, green: 0.15, blue: 0.15)
        case .green: return Color(red: 0.15, green: 0.75, blue: 0.3)
        case .yellow: return Color(red: 0.95, green: 0.8, blue: 0.1)
        }
    }
    
    var displayName: String {
        rawValue.uppercased()
    }
    
    var glowColor: Color {
        // Return a lighter/brighter version for glow effect
        switch self {
        case .blue: return Color(red: 0.3, green: 0.5, blue: 1.0)
        case .red: return Color(red: 1.0, green: 0.3, blue: 0.3)
        case .green: return Color(red: 0.3, green: 1.0, blue: 0.5)
        case .yellow: return Color(red: 1.0, green: 0.95, blue: 0.4)
        }
    }
    
    /// Returns the teams used for a given team count
    static func teams(for count: Int) -> [TeamColor] {
        if count == 4 {
            return [.blue, .red, .green, .yellow]
        } else {
            return [.blue, .red]
        }
    }
}
