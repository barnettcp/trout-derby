# Milestone: Final Game (Multiplayer)

## Goal
Multiplayer version deployable to itch.io where multiple players share the same pond in real time with persistent stats.

## Prerequisites
- Prototype milestone complete and stable

## Tasks

### Networking
- [ ] Choose and configure Godot networking (WebSocket or WebRTC for HTML5)
- [ ] Server setup: always-on, manages round lifecycle
- [ ] Client-server communication protocol
- [ ] Player join/leave during active round

### Multiplayer Gameplay
- [ ] Multiple player characters visible in the same pond
- [ ] Server-authoritative fish state
- [ ] Server-authoritative bite resolution
- [ ] Client-authoritative player movement with server validation
- [ ] Cast and catch events broadcast to all clients

### State Sync
- [ ] Player position sync with interpolation
- [ ] Derby timer sync
- [ ] Score sync and live scoreboard updates
- [ ] Fish-caught events broadcast (not fish positions)

### Persistence and Stats
- [ ] Player identity via localStorage (name + generated ID)
- [ ] Awards saved across rounds
- [ ] Leaderboard: total fish, total awards, best round, trophy count
- [ ] Leaderboard UI screen

### Deployment
- [ ] Godot HTML5 export configuration
- [ ] Server deployment (hosting TBD)
- [ ] itch.io page setup
- [ ] Basic mobile touch input mapping

### Polish
- [ ] Handle edge cases: disconnect, mid-round join, full server
- [ ] Lobby or waiting state between rounds
- [ ] Smooth transitions between screens
- [ ] Playtesting with 2+ concurrent players

## Acceptance Criteria
- Multiple players can join the same pond from separate browsers
- Each player sees other players moving and casting
- Fish state is managed by the server; no cheating via client
- Catching a fish updates the live scoreboard for all players
- Derby rounds cycle automatically on the server
- Awards persist in the browser between sessions
- Leaderboard displays all-time stats
- Game runs in a browser via itch.io
