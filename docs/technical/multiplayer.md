# Multiplayer

## Network Model
- Which Godot networking approach (ENet, WebSocket, WebRTC)
- Client-server vs. peer-to-peer
- Server authority: what the server owns vs. what clients own

## Authority
- Server authoritative over:
  - Fish positions and state
  - Bite resolution
  - Derby timer and round lifecycle
  - Score tallying
- Client authoritative over:
  - Own player movement
  - Cast input (validated by server)

## State Synchronization
- What gets synced to all clients:
  - Player positions and actions (cast, reel, idle)
  - Fish caught events (not fish positions, since fish are invisible)
  - Derby timer
  - Scoreboard
- What stays server-only:
  - Fish positions and movement
  - Bite roll results before resolution
- Sync frequency and interpolation strategy

## Lobby and Join Flow
- Always-on server model (no lobby creation by players)
- Player connects and joins the current active round
- Mid-round join handling: player starts with zero score
- Disconnection handling: player removed, fish they hooked released
- Reconnection: treated as a new join (no state recovery)

## Scaling Considerations
- Max players per pond instance
- When to spin up additional pond instances
- Bandwidth estimates per player

## Deployment
- Target platform: itch.io (HTML5 export)
- Server hosting options
- Mobile considerations (touch input mapping)
