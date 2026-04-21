# Architecture

## Engine
- Godot 4 with GDScript
- 2D, top-down perspective

---

## World Coordinate Scale

Godot 2D uses pixels as its native unit. All game distances are designed in meters and converted using a fixed scale.

| Scale | Value |
|---|---|
| Meters per pixel | **0.33 m/px** |
| Pixels per meter | ~3.03 px/m |

### Key Distance Reference

| Distance | Meters | Pixels (approx.) |
|---|---|---|
| Min cast distance | 5 m | 15 px |
| Max cast distance | 18 m | 55 px |
| Fish bite radius | 1 m | 3 px |
| Max pond width (center-reachable) | 36 m | ~109 px |

> **Pond sizing note:** For a player on the shoreline to reach the pond center with a max cast, the pond must be no wider than ~109px (36m diameter). UI elements (HUD, font sizes, border widths) are always defined in raw pixels independent of this scale.

## Project Structure
<!-- Full repo layout. project/ is the Godot project root; tools/ lives alongside it. -->
```
trout-derby/                         # repo root
├── docs/
├── tools/                           # Data pipeline — outside Godot project
│   ├── fish_pool.csv                # Source of truth — hand-authored, edit here
│   ├── generate_fish.py             # Reads CSV, rolls unset attributes, writes fish_data.json
│   └── notebooks/
│       └── fish_simulation.ipynb    # For tuning distributions and visualizing behavior
└── project/                         # Godot project root
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
    │   └── ui/              # Inkscape-exported SVGs/PNGs
    ├── data/
    │   ├── fish_data.json   # Generated — read by Godot at startup
    │   └── pond_data.json
    └── autoloads/
        ├── game_state.gd
        └── config.gd
```

---

## Data Pipeline

Fish data is authored in CSV and converted to JSON for Godot. The JSON file is what the game reads; the CSV is what you edit.

| File | Format | Purpose | Edit by hand? |
|---|---|---|---|
| `fish_pool.csv` | CSV | Source of truth for all fish attributes | Yes |
| `fish_data.json` | JSON | Generated output read by Godot at startup | Only for quick tweaks |
| `generate_fish.py` | Python | Reads CSV, rolls unset stats, writes JSON | No |
| `fish_simulation.ipynb` | Jupyter | Simulate movement, tune distributions | No |

**Pipeline:**
1. Edit `fish_definitions.csv` (or run the notebook to tune values)
2. Run `generate_fish.py` to produce `fish_data.json`
3. Godot reads `fish_data.json` via `FileAccess` + `JSON.parse_string()` on startup

`fish_data.json` can be committed to the repo or gitignored — either is fine since it is fully reproducible from the CSV.

## Scene Tree Overview
- Root
  - Main (game manager, derby timer)
  - Pond (polygon, water area, collision)
  - Players (container for player nodes)
  - Fish (container for fish nodes, invisible to players)
  - UI (HUD, scoreboard, menus)

## Key Systems
- **Derby Manager**: round lifecycle, timer, start/end logic
- **Fish Spawner**: instantiates fish with attributes, places randomly inside pond polygon (prototype); noise-map distributions deferred to post-prototype
- **Casting System**: input handling, direction calc, distance timing, bobber placement
- **Bite System**: proximity checks between fish and bobbers, bite rolls
- **Score Tracker**: per-player fish count, awards, persistence

---

## Player Spawn

| Scope | Behavior |
|---|---|
| Prototype | Player spawns at a fixed position near the top-left of the screen, outside the pond, facing the pond |
| Final Game | Random position within a spawn zone to the left or right of the pond, facing inward |

Spawn position is placed by feel during scene construction; no JSON needed.

## Signal Flow
- Outline major signals between systems
  - `cast_landed(position)` -> Bite System listens
  - `fish_bit(fish, bobber)` -> Player notified for hook window
  - `fish_caught(fish, player)` -> Score Tracker, Fish Spawner
  - `derby_ended()` -> UI shows scoreboard, systems reset

## Collision Layers

| Layer | Name | Collides With | Notes |
|---|---|---|---|
| 1 | Pond Boundary | Player, Fish, Bobber | Keeps player and fish inside/outside |
| 2 | Player | Pond Boundary | Cannot enter water |
| 3 | Fish | Pond Boundary | Contained within polygon |
| 4 | Bobber | Pond Boundary | Invalid if it lands outside water |
