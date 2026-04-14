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
- [ ] Square block character with directional indicator
- [ ] WASD/arrow movement
- [ ] Collision with pond boundary

### Fishing
- [ ] Cursor-based cast direction
- [ ] Timing-based cast distance (hold and release)
- [ ] Bobber placement in water
- [ ] Line drawn from rod to bobber
- [ ] Bite detection (proximity to fish)
- [ ] Bite visual/audio cue
- [ ] Hook reaction window
- [ ] Fish caught on successful hook

### Fish
- [ ] Fish spawner with configurable count
- [ ] Tick-based movement system
- [ ] Anti-crowding behavior
- [ ] Pond boundary containment
- [ ] Length/weight attribute generation
- [ ] Trophy fish (at least one functional)

### Derby
- [ ] Configurable round timer (2 or 5 min)
- [ ] Round start and end flow
- [ ] Score tally at end

### UI
- [ ] Main menu (start button, timer config)
- [ ] In-game HUD (timer, fish count)
- [ ] End-of-round scoreboard
- [ ] Catch notification popup

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
