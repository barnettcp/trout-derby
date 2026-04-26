# Multiplayer

*This document covers the final game milestone. Multiplayer is not required for the prototype.*

Multiplayer is the ultimate goal of this game - it should feel light and casual, but also is more fun if people can join a derby with their friends. Initially, I'm not going to worry about scaling as it is a problem that I would like to have, but not one to solve for early. If 100 people want to fish in the pond and have an expected catch of 0.5 fish per player, good for them! At that point it would be worthwhile to examine better approaches.

If scaling is a problem, we could have multiple concurrent derby "rooms" (servrs) that users could join. Also, it could be nice to have users able to generate a private derby that is sharable via some sort of Alpha or Alphanumeric code (e.g. HXCZYJ.. or whatever) and join a room with their friends. Since fish exist in the same way across all derbies, all awards and statistics are applicable regardless of the room type.

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
