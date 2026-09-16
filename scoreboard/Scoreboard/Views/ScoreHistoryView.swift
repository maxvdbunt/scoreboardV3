import SwiftUI

struct ScoreHistoryView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack(spacing: 0) {
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
                    
                    Text("ALL SCORES")
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Button(action: {}) {
                        HStack {
                            Image(systemName: "chevron.left")
                            Text("Back")
                        }
                        .opacity(0)
                    }
                }
                .padding()
                
                if appState.scoreHistory.isEmpty {
                    Spacer()
                    Text("No scores yet")
                        .foregroundColor(.gray)
                        .font(.system(size: 18))
                    Spacer()
                } else {
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(appState.scoreHistory.reversed()) { result in
                                VStack(alignment: .leading, spacing: 12) {
                                    Text("\(result.teamCount) Teams • \(result.timeString)")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                    
                                    ForEach(result.scores, id: \.team) { scoreItem in
                                        HStack {
                                            Circle()
                                                .fill(scoreItem.team.color)
                                                .frame(width: 12, height: 12)
                                            Text(scoreItem.team.displayName)
                                                .foregroundColor(.white)
                                            Spacer()
                                            Text("\(scoreItem.score)")
                                                .font(.headline)
                                                .fontWeight(.bold)
                                                .foregroundColor(.white)
                                        }
                                    }
                                }
                                .padding()
                                .background(.ultraThinMaterial)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                                .padding(.horizontal)
                            }
                        }
                        .padding(.vertical)
                    }
                }
            }
        }
    }
}
