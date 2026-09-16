import SwiftUI
import UIKit

/// Manages device orientation locking for the scoreboard views
class OrientationManager {
    static let shared = OrientationManager()
    
    /// The currently allowed orientations
    var supportedOrientations: UIInterfaceOrientationMask = .all
    
    /// Lock to landscape orientations
    func lockLandscape() {
        supportedOrientations = .landscape
        // Request rotation
        if #available(iOS 16.0, *) {
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
            windowScene.requestGeometryUpdate(.iOS(interfaceOrientations: .landscape))
        }
    }
    
    /// Unlock to all orientations 
    func unlockOrientation() {
        supportedOrientations = .all
        if #available(iOS 16.0, *) {
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
            windowScene.requestGeometryUpdate(.iOS(interfaceOrientations: .all))
        }
    }
}

/// Custom AppDelegate to support orientation management
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return OrientationManager.shared.supportedOrientations
    }
}
