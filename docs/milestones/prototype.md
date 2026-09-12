# Milestone: Prototype (Single Player)

## Goal
Playable single-player fishing game with one pond, a full fishing loop, and a derby timer.

## Tasks

### Setup
- [x] Initialize Godot 4 project with folder structure
- [x] Configure base resolution and display settings
- [x] Set up autoloads (game state, config)

### Pond and Environment
- [x] Create pond polygon (8-point, hand-drawn feel)
- [x] Green background, blue water fill
- [x] Collision boundary so player cannot enter water

### Player
- [x] Rectangular block character (32×18 px body) with round head; single sprite rotated by Godot
- [ ] WASD/arrow movement at 1.1 m/s (~17 px/s); snaps to 4 cardinal directions
- [x] Collision with pond boundary

### Fishing
- [x] Cursor-based cast direction within 150° forward arc
- [x] Timing-based cast distance (hold and release, 1 s fill)
- [x] Bobber arc animation (parabolic: sine-driven scale, peaks at 1.5× at midpoint)
- [x] Bobber placement in water
- [x] Line drawn from rod to bobber
- [x] Recall bobber input (click/Space; 0.5 s cooldown)
- [x] Bite detection (proximity to fish)
- [x] Bite visual/audio cue
- [x] Hook reaction window (1 s)
- [x] Fish caught on successful hook; auto-reel over 2 s

### Fish
- [x] Fish spawner with configurable count
- [x] Tick-based movement system
- [x] Anti-crowding behavior
- [x] Pond boundary containment
- [x] Length/weight attribute generation
- [x] Trophy fish (at least one functional)

### Derby
- [x] Configurable round timer (2 or 5 min)
- [x] 10-second pre-derby countdown overlay
- [x] Round start and end flow
- [x] Score tally at end
- [x] 1-minute between-derby countdown; dismissible summary; auto-close at 10 s remaining

### UI
- [x] Main menu ("Join Derby" primary button, settings, exit)
- [x] In-game HUD (timer, fish count)
- [x] End-of-round scoreboard with awards
- [x] Catch notification popup (portrait, species, length, weight, rounds since caught)

### Audio
- [x] Cast sound
- [x] Bite indicator sound
- [x] Catch sound
- [ ] Round end sound

## Acceptance Criteria
- Player can move around the pond and cannot walk into water
- Player can cast into the water using direction + timing
- Fish move around invisibly and can bite the bobber
- Player can hook and catch fish
- Caught fish are removed from the pond
- Derby timer counts down and ends the round
- Score is displayed at the end
- At least one trophy fish can appear and be caught
