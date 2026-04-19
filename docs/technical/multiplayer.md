# Multiplayer

*This document covers the final game milestone. Multiplayer is not required for the prototype.*

---

## Network Model — *Decision Required*

**Option A — ENet**
Godot's built-in UDP-based protocol. Fast, but not HTML5-compatible without a relay.

**Option B — WebSocket**
HTTP-based, works natively in browsers. Higher latency than ENet but simpler for itch.io deployment.

**Option C — WebRTC**
Peer-to-peer capable, browser-compatible. More complex setup.

> **Selected:** TBD
> **Topology:** Client-server (not peer-to-peer)

---

## Authority

| System | Authority | Notes |
|---|---|---|
| Fish positions and state | Server | Fish are invisible to clients anyway |
| Bite resolution | Server | |
| Derby timer | Server | |
| Score tallying | Server | |
| Player movement | Client | Server validates |
| Cast input | Client | Server validates landing point |

---

## State Synchronization

| Data | Synced To | Notes |
|---|---|---|
| Player positions | All clients | With interpolation |
| Player actions (cast, reel, idle) | All clients | |
| Fish caught events | All clients | Not fish positions |
| Derby timer | All clients | |
| Scoreboard | All clients | |
| Fish positions and movement | Server only | |
| Bite roll results | Server only | Until resolved |

| Variable | Description | Value | Notes |
|---|---|---|---|
| Sync Frequency | How often player state is broadcast | TBD | |
| Interpolation Strategy | How clients smooth remote player movement | TBD | |

---

## Lobby and Join Flow

- Always-on server; no lobby creation by players
- Player connects and joins the current active round
- Mid-round join: player starts with zero score
- Disconnect: player removed, any hooked fish released
- Reconnect: treated as a new join (no state recovery)

---

## Scaling

| Variable | Description | Value | Notes |
|---|---|---|---|
| Max Players | Per pond instance | TBD | |
| Instance Spin-up | When to add a new pond | TBD | |

---

## Deployment

| Item | Decision | Notes |
|---|---|---|
| Export target | HTML5 | For itch.io |
| Server host | TBD | |
| Mobile input | TBD | Touch mapping for final game |
