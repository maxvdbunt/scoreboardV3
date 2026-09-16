# Scoreboard

A polished, modern iPhone scoreboard app built with Swift and SwiftUI. Designed for tracking scores in 2-team or 4-team games with a clean, premium interface optimized for landscape use.

## Purpose

Scoreboard provides a fast, beautiful way to keep score during games, matches, or any competitive activity. Just tap a team's side to add a point — it's that simple. The app is designed to be used in landscape orientation so the scoreboard is large and readable from a distance.

## Features

### Core
- **2-Team Mode** — Split-screen landscape scoreboard (Blue vs Red)
- **4-Team Mode** — Four-column landscape scoreboard (Blue, Red, Green, Yellow)
- **Tap to Score** — Tap anywhere on a team's area to add +1
- **Instant Response** — No input delay, supports rapid tapping
- **Score Animations** — Subtle scale animation on score change

### Game Management
- **Reset Scores** — Reset all scores to 0 with confirmation dialog
- **Score History** — Previous game results saved per session
- **View All Scores** — Browse score history from the current session

### Timer
- **Configurable Timer** — Enable/disable in Settings
- **Start / Pause / Reset** — Full timer controls on the scoreboard
- **Accurate Timing** — Date-based tracking, not tick counting
- **Non-intrusive** — Timer sits at the top, never blocks scoring

### Visual Design
- **Liquid Glass-Inspired UI** — Modern frosted-glass button styling
- **Team Color Glow** — Optional glow effect per team (toggle in Settings)
- **Smooth Animations** — Native SwiftUI transitions throughout
- **Responsive Layout** — Scales correctly across all iPhone sizes

### Settings (Persistent)
- Timer ON/OFF
- Team Color Glow ON/OFF

### App Lifecycle
- Opens to Main Menu on every fresh launch
- Game data, scores, timer, and history are session-only (not persisted)
- Settings survive app restarts

## Project Structure

```
scoreboard/
├── README.md
├── Scoreboard.xcodeproj/
│   └── project.pbxproj
└── Scoreboard/
    ├── ScoreboardApp.swift          # App entry point
    ├── Info.plist                    # Bundle configuration
    ├── Assets.xcassets/             # Colors & App Icon
    ├── Models/
    │   ├── AppState.swift           # Central state management
    │   ├── GameResult.swift         # Score history data model
    │   ├── TeamColor.swift          # Team color definitions
    │   └── TimerManager.swift       # Timer logic
    ├── Views/
    │   ├── MainMenuView.swift       # Main menu screen
    │   ├── TeamSelectionView.swift  # 2/4 team picker
    │   ├── ScoreboardView.swift     # Active scoreboard
    │   ├── ScoreHistoryView.swift   # Score history list
    │   ├── SettingsView.swift       # App settings
    │   └── Components/
    │       ├── TeamScoreView.swift  # Single team score area
    │       └── GlassButtonStyle.swift # Liquid Glass button style
    └── Utilities/
        └── OrientationManager.swift # Landscape lock utility
```

## Technologies

- **Language**: Swift 5.9+
- **UI Framework**: SwiftUI
- **Minimum iOS**: 17.0
- **Target Device**: iPhone
- **Persistence**: `@AppStorage` (UserDefaults) for settings only
- **Dependencies**: None — 100% native Apple frameworks

## How to Open in Xcode

1. Clone or download the repository
2. Open `Scoreboard.xcodeproj` in Xcode 15+
3. The project is ready to build immediately

## How to Build

1. Open the project in Xcode
2. Select your target device or simulator (iPhone)
3. Press **⌘B** to build
4. Verify zero errors in the build log

## How to Install / Test on iPhone

### Simulator
1. Select an iPhone simulator from the Xcode device menu
2. Press **⌘R** to build and run
3. Rotate the simulator to landscape (⌘→) for the scoreboard

### Physical Device
1. Connect your iPhone via USB
2. In Xcode, select your iPhone from the device menu
3. You may need to:
   - Sign in with your Apple ID under Xcode → Settings → Accounts
   - Select your Personal Team under Signing & Capabilities
   - Trust the developer profile on your iPhone (Settings → General → VPN & Device Management)
4. Press **⌘R** to build and install
5. The app will launch on your device

## How to Publish to GitHub

1. Create a new repository on GitHub
2. In Terminal:
   ```bash
   cd scoreboard
   git init
   git add .
   git commit -m "Initial commit: Scoreboard app"
   git remote add origin https://github.com/YOUR_USERNAME/scoreboard.git
   git push -u origin main
   ```
3. Others can clone and open `Scoreboard.xcodeproj` directly

## Architecture

### State Management

| Category | Storage | Survives Restart? |
|----------|---------|-------------------|
| Settings (timer, glow) | `@AppStorage` | ✅ Yes |
| Active game (scores, timer) | In-memory `@Published` | ❌ No |
| Score history | In-memory array | ❌ No |

### Navigation

Navigation is managed via an `AppScreen` enum in `AppState`. All transitions use SwiftUI's native animation system. The navigation flow:

```
Main Menu
├── Start → Team Selection
│   ├── 2 Teams → Scoreboard (landscape)
│   │   ├── View All Scores
│   │   └── Back
│   └── 4 Teams → Scoreboard (landscape)
│       ├── View All Scores
│       └── Back
└── Settings
    └── Back
```

### Key Design Decisions

- **Single `AppState` ObservableObject**: All state in one place for simplicity and predictable resets
- **`@AppStorage` for settings**: Native persistence with zero boilerplate
- **`Date`-based timer**: Avoids drift from `Timer` tick counting under CPU load
- **`GeometryReader` layouts**: Responsive to all screen sizes without magic numbers
- **Custom `ButtonStyle`**: Reusable Liquid Glass look via `.ultraThinMaterial` overlays
- **No third-party dependencies**: Ships with native Apple frameworks only

## Instructions for Future Agents

> **⚠️ You MUST read this entire README before modifying the project.**

### Critical Rules

1. **Do NOT add persistence for game data.** Scores, timer state, and score history are intentionally session-only. When the app is terminated and reopened, everything game-related must start fresh from the Main Menu.

2. **Do NOT rely on app termination callbacks.** iOS does not guarantee `applicationWillTerminate` or scene-phase callbacks on force-quit. The app's architecture assumes in-memory state is lost on termination — this is by design.

3. **Settings are the ONLY persistent data.** `timerEnabled` and `glowEnabled` use `@Published` properties with `UserDefaults` `didSet` sync (not `@AppStorage`, which doesn't trigger `objectWillChange` on `ObservableObject`). Nothing else should be persisted.

4. **Keep the scoreboard landscape-optimized.** The scoring views must work well in landscape. Menu and settings can be portrait-friendly.

5. **Maintain performance.** Score taps must respond instantly. Avoid expensive computations in tap handlers or in views that re-render frequently (timer, score animations).

6. **No third-party dependencies.** Use native SwiftUI and Apple frameworks only.

7. **Test on multiple iPhone sizes.** The layout uses `GeometryReader` for responsive sizing. Verify that 2-team and 4-team modes look correct on SE, standard, and Max-size iPhones.

### State Architecture

- `AppState` is the single source of truth, injected as an `@EnvironmentObject`
- Navigation is driven by `AppState.currentScreen` enum
- `TimerManager` is a separate `ObservableObject` owned by `AppState`
- Score history is an `[GameResult]` array in memory

### File Conventions

- Views are in `Views/`
- Reusable components are in `Views/Components/`
- Data models are in `Models/`
- Utilities are in `Utilities/`
- All files use standard Swift naming conventions

## Current Implementation Status

- [x] README created
- [x] Project structure set up
- [x] Main Menu implemented
- [x] Team Selection implemented
- [x] 2-Team Scoreboard implemented
- [x] 4-Team Scoreboard implemented
- [x] Scoring implemented
- [x] Reset + Score History implemented
- [x] View All Scores implemented
- [x] Settings implemented
- [x] Timer implemented
- [x] Team Color Glow implemented
- [x] Animations and polish
- [x] App icon configured
- [x] Code review and consistency verification
- [x] README updated with final status

### App Icon

The app icon (red background + glass "3") needs to be generated on a Mac by running:

```bash
cd scoreboard
swift scripts/generate_icon.swift
```

This creates the `AppIcon.png` in the asset catalog. Alternatively, you can create a 1024×1024 PNG manually and place it at `Scoreboard/Assets.xcassets/AppIcon.appiconset/AppIcon.png`.

---

## 🚀 Direct op je iPhone zetten via GitHub (Zonder Mac!)

Omdat je geen Mac hebt, is er een complete **Progressive Web App (PWA)** versie meegeleverd in de repository (`index.html`, `manifest.json`, `sw.js`, `icon-512.svg`). Deze heeft exact dezelfde functies, Liquid Glass styling, 2-team / 4-team modi, scorepop animaties, timer en glow.

### Stap 1: Testen op je Windows laptop
Dubbelklik op `index.html` in de map `scoreboard/`. De app opent direct in je browser (Chrome / Edge / Firefox) en je kunt direct testen!

### Stap 2: Naar GitHub pushen
Open een terminal (PowerShell of Git Bash) in deze map en voer uit:
```bash
git init
git add .
git commit -m "Initial commit Scoreboard"
git branch -M main
git remote add origin https://github.com/JOUW_GEBRUIKERSNAAM/scoreboard.git
git push -u origin main
```

### Stap 3: GitHub Pages aanzetten
1. Ga op GitHub naar je repository.
2. Klik op **Settings** (bovenaan).
3. Klik links op **Pages**.
4. Onder **Build and deployment** > **Branch**: kies `main` en map `/ (root)` of `/docs`.
5. Klik op **Save**.
6. Binnen 1 minuut geeft GitHub je een link, bijvoorbeeld:  
   `https://JOUW_GEBRUIKERSNAAM.github.io/scoreboard/`

### Stap 4: Installeren op je iPhone
1. Open de GitHub Pages link in **Safari** op je iPhone.
2. Tik onderin op de **Deel-knop** (vierkantje met pijl omhoog).
3. Scroll omlaag en tik op **Zet op beginscherm** ("Add to Home Screen").
4. Tik op **Voeg toe**.

Nu staat het rode **Scoreboard** icoon met de glazen **3** op het beginscherm van je iPhone! Wanneer je erop tikt opent het op **volledig scherm (geen Safari balken)** en werkt het exact als een echte iOS app, ook offline!

