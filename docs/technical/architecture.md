# Architecture

## Engine
- Godot 4 with GDScript
- 2D, top-down perspective

## Project Structure
<!-- Proposed directory layout for the Godot project -->
```
project/
├── scenes/
│   ├── main.tscn
│   ├── pond.tscn
│   ├── player.tscn
│   ├── fish.tscn
│   ├── fishing_rod.tscn
│   ├── bobber.tscn
│   └── ui/
│       ├── hud.tscn
│       ├── scoreboard.tscn
│       └── main_menu.tscn
├── scripts/
│   ├── main.gd
│   ├── pond.gd
│   ├── player.gd
│   ├── fish.gd
│   ├── fishing_rod.gd
│   ├── bobber.gd
│   ├── derby_manager.gd
│   ├── fish_spawner.gd
│   └── ui/
├── assets/
│   ├── sprites/
│   ├── audio/
│   └── ui/          # Inkscape-exported SVGs/PNGs
├── data/
│   ├── fish_data.json
│   └── pond_data.json
└── autoloads/
    ├── game_state.gd
    └── config.gd
```

## Scene Tree Overview
- Root
  - Main (game manager, derby timer)
  - Pond (polygon, water area, collision)
  - Players (container for player nodes)
  - Fish (container for fish nodes, invisible to players)
  - UI (HUD, scoreboard, menus)

## Key Systems
- **Derby Manager**: round lifecycle, timer, start/end logic
- **Fish Spawner**: instantiates fish with attributes, places via noise/map
- **Casting System**: input handling, direction calc, distance timing, bobber placement
- **Bite System**: proximity checks between fish and bobbers, bite rolls
- **Score Tracker**: per-player fish count, awards, persistence

## Signal Flow
- Outline major signals between systems
  - `cast_landed(position)` -> Bite System listens
  - `fish_bit(fish, bobber)` -> Player notified for hook window
  - `fish_caught(fish, player)` -> Score Tracker, Fish Spawner
  - `derby_ended()` -> UI shows scoreboard, systems reset

## Collision Layers
- Layer assignments for pond boundary, players, fish, bobbers
- Players collide with pond edge (cannot enter water)
- Fish contained within pond polygon
- Bobbers only valid when inside water polygon
