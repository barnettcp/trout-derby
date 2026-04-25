# Milestone: Prototype (Single Player)

## Goal
Playable single-player fishing game with one pond, a full fishing loop, and a derby timer.

## Tasks

### Setup
- [ ] Initialize Godot 4 project with folder structure
- [ ] Configure base resolution and display settings
- [ ] Set up autoloads (game state, config)

### Pond and Environment
- [ ] Create pond polygon (8-point, hand-drawn feel)
- [ ] Green background, blue water fill
- [ ] Collision boundary so player cannot enter water

### Player
- [ ] Rectangular block character (32×18 px body) with round head; single sprite rotated by Godot
- [ ] WASD/arrow movement at 1.1 m/s (~17 px/s); snaps to 4 cardinal directions
- [ ] Collision with pond boundary

### Fishing
- [ ] Cursor-based cast direction within 150° forward arc
- [ ] Timing-based cast distance (hold and release, 1 s fill)
- [ ] Bobber arc animation (parabolic: sine-driven scale, peaks at 1.5× at midpoint)
- [ ] Bobber placement in water
- [ ] Line drawn from rod to bobber
- [ ] Recall bobber input (click/Space; 0.5 s cooldown)
- [ ] Bite detection (proximity to fish)
- [ ] Bite visual/audio cue
- [ ] Hook reaction window (1 s)
- [ ] Fish caught on successful hook; auto-reel over 2 s

### Fish
- [ ] Fish spawner with configurable count
- [ ] Tick-based movement system
- [ ] Anti-crowding behavior
- [ ] Pond boundary containment
- [ ] Length/weight attribute generation
- [ ] Trophy fish (at least one functional)

### Derby
- [ ] Configurable round timer (2 or 5 min)
- [ ] 10-second pre-derby countdown overlay
- [ ] Round start and end flow
- [ ] Score tally at end
- [ ] 1-minute between-derby countdown; dismissible summary; auto-close at 10 s remaining

### UI
- [ ] Main menu ("Join Derby" primary button, settings, exit)
- [ ] In-game HUD (timer, fish count)
- [ ] End-of-round scoreboard with awards
- [ ] Catch notification popup (portrait, species, length, weight, rounds since caught)

### Audio
- [ ] Cast sound
- [ ] Bite indicator sound
- [ ] Catch sound
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
