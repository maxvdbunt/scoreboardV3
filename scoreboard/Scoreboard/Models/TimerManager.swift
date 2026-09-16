import Foundation
import Combine

/// Manages the timer for a game
class TimerManager: ObservableObject {
    @Published var elapsedSeconds: TimeInterval = 0
    @Published var isRunning: Bool = false
    
    private var timer: Timer?
    private var startDate: Date?
    private var accumulatedTime: TimeInterval = 0
    
    var displayString: String {
        let totalSeconds = Int(elapsedSeconds)
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func start() {
        guard !isRunning else { return }
        
        startDate = Date()
        isRunning = true
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            guard let self = self, let startDate = self.startDate else { return }
            self.elapsedSeconds = self.accumulatedTime + Date().timeIntervalSince(startDate)
        }
    }
    
    func pause() {
        guard isRunning else { return }
        
        if let startDate = startDate {
            accumulatedTime += Date().timeIntervalSince(startDate)
        }
        
        timer?.invalidate()
        timer = nil
        isRunning = false
    }
    
    func reset() {
        timer?.invalidate()
        timer = nil
        elapsedSeconds = 0
        accumulatedTime = 0
        startDate = nil
        isRunning = false
    }
    
    deinit {
        timer?.invalidate()
    }
}
