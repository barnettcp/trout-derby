# Game Design Document: Trout Derby

## Overview
Trout Derby is a simple top-down fishing game where the player can walk around a pond and cast fishing pole into it and hope to catch a fish. Time is limited, and the winning player is the one who caught the most fish. All fish are unique, and will be re-stocked in the next derby.

The vibe should be a mix of casual, and very casual. A player should come back to this game because it provides a little luck, a little satisfaction, and a lot of chill vibes. They can hop in or out as needed, without consequence; the fish will be back in a future derby. The goal would be to initially release for free in-browser play on itch.io, and then pursue a mobile game. If servers were always running, players could always hop into the game and try to catch some fish.

## Core Loop
- Player joins a derby round
    - Prototype: The derby round begins when the player joins
    - Final Game: The derby round happens on a fixed timer and the player can join an in-progress derby, with no adjustment to scoring. They would then participate fully in the next derby.
- Move around the pond as desired, cast into the water where they think there might be fish
- Wait for a bite, set the hook, reel in the fish
- Or, alternatively, reel the line in and re-cast elsewhere
- Catch, cast, move, and repeat until the derby timer expires
- Derby summary: Tally score, distribute awards, re-stock fish

## Controls
- Player Movement: 
    - WASD / arrow keys for itch.io
    - Simple 
- Cast direction: As the player moves the character around, the mouse moves around the cursor to determine the casting direction.
- Cast distance: The user sees a hold and release power bar, with 100% meaning a full-distance cast and 0% meaning no cast.
- Hook set: When a fish bites, there is a short-yet-doable reaction window for the user to set the hook. This is done with a double-click (mouse/keyboard) or long-press (mobile)
- Reeling: The user begins reeling by clicking the mouse or a long-press and holding 

## Scope

### Prototype (Single Player)
The prototype is intentionally simple. When in doubt, do not include a feature in the prototype. The goal is to learn Godot, get a simple player in, and be able to catch fish. From there, tweak parameters for fish behavior and bite mechanics as needed to make the game feel relaxing.

- One pond, one player, fixed fish count
- Three distinct trophy fish. One random trophy fish spawns in for each derby 
- Full fishing loop: cast, hook, reel, score
- Derby timer (Variable-controlled: 2 or 5 minutes to begin)
- Minimal UI, minimal sound, simple animation.
- Art using defined color schemes

### Final Game (Multiplayer)
The final game is intended to be a casual passtime: a game that one would play on a train or as a passenger in a car. Other actual players competing for the same fish should feel more like camaraderie and less like sport, since there's always next round if this one doesn't work out.

- Same pond, multiple concurrent players, fixed fish count
- All fish unique, some procedural and some crafted. Most are simple trout, however
- Persistent leaderboard and stats
- Consistent-yet-silent addition of new trophy fish that may randomly appear each round
- Deployable to itch.io, then begin work to make available on mobile
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
