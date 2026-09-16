import SwiftUI

struct SettingsView: View {
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
                
                Text("SETTINGS")
                    .font(.system(size: 32, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .padding(.bottom, 32)
                
                VStack(spacing: 0) {
                    Toggle(isOn: $appState.timerEnabled) {
                        HStack {
                            Image(systemName: "timer.circle")
                                .foregroundColor(.white)
                            Text("Timer")
                                .foregroundColor(.white)
                        }
                    }
                    .tint(.blue)
                    .padding()
                    
                    Divider()
                        .background(Color.white.opacity(0.2))
                        .padding(.horizontal)
                    
                    Toggle(isOn: $appState.glowEnabled) {
                        HStack {
                            Image(systemName: "sparkles")
                                .foregroundColor(.white)
                            Text("Team Color Glow")
                                .foregroundColor(.white)
                        }
                    }
                    .tint(.blue)
                    .padding()
                }
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .padding(.horizontal, 32)
                
                Spacer()
            }
        }
    }
}
