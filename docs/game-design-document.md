# Game Design Document: Trout Derby

## Overview
- Genre, platform, target audience
- One-paragraph pitch
- Core fantasy: a laid-back, arcade-style fishing game

## Core Loop
- Player joins a derby round
- Move around the pond, cast into the water
- Wait for a bite, set the hook, reel in the fish
- Repeat until the derby timer expires
- Tally score, distribute awards

## Controls
- Movement: WASD / arrow keys
- Cast direction: mouse/cursor position (direction only, not target location)
- Cast distance: timing-based input (min/max)
- Hook set: click or key press within a short reaction window
- Reeling: TBD input method

## Scope

### Prototype (Single Player)
- One pond, one player, fixed fish count
- Full fishing loop: cast, hook, reel, score
- Derby timer (configurable: 2 or 5 minutes)
- Minimal UI, minimal sound, simple animation

### Final Game (Multiplayer)
- Same pond, multiple concurrent players
- Persistent leaderboard and stats
- Deployable to itch.io, possibly mobile
- Always-on server; players drop in/out freely

## Related Documents
- [Fishing Mechanics](mechanics/fishing.md)
- [Fish Behavior](mechanics/fish-behavior.md)
- [Fish Catalog](mechanics/fish-catalog.md)
- [Scoring](mechanics/scoring.md)
- [Architecture](technical/architecture.md)
- [Multiplayer](technical/multiplayer.md)
- [Data Models](technical/data-models.md)
- [Style Guide](art/style-guide.md)
- [UI Layout](art/ui-layout.md)
- [Prototype Milestone](milestones/prototype.md)
- [Final Game Milestone](milestones/final-game.md)
