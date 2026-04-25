# Architecture

## Engine
- Godot 4 with GDScript
- 2D, top-down perspective

---

## World Coordinate Scale

Godot 2D uses pixels as its native unit. All game distances are designed in meters; the scale below converts between them.

| Scale | Value |
|---|---|
| Pixels per meter | **15 px/m** |

This is derived from the pond dimensions: the pond is ~550px wide, representing a 36m diameter (center reachable from shoreline on a max cast).

### Key Distance Reference

| Distance | Meters | Pixels |
|---|---|---|
| Min cast distance | 5 m | 75 px |
| Max cast distance | 18 m | 270 px |
| Fish bite radius | 1 m | 15 px |
| Pond width (approx.) | 36 m | ~550 px |
| Pond height (approx.) | 33 m | ~500 px |

> UI elements (HUD panels, font sizes, border widths) are always defined in raw pixels independent of this scale.

---

## Player Variables

| Variable | Value | Notes |
|---|---|---|
| Movement speed | 1.1 m/s → **~17 px/s** | Slightly slower than average walking pace (1.4 m/s); defined as a configurable constant in `player.gd` |

## Project Structure
<!-- Full repo layout. project/ is the Godot project root; tools/ lives alongside it. -->
```
trout-derby/                         # repo root
├── docs/
├── tools/                           # Data pipeline — outside Godot project
│   ├── fish_pool.csv                # Source of truth — hand-authored, edit here
│   ├── generate_fish_json.py        # Reads CSV, rolls unset attributes, writes fish_data.json
│   └── notebooks/
│       ├── generate_fish.ipynb      # Simulate distributions, generate fish_pool.csv
│       └── pond_editor.ipynb        # Place pond vertices, visualize, export pond_data.json
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

### Fish

| File | Format | Purpose | Edit by hand? |
|---|---|---|---|
| `fish_pool.csv` | CSV | Source of truth for all fish attributes | Yes |
| `fish_data.json` | JSON | Generated output read by Godot at startup | Only for quick tweaks |
| `generate_fish_json.py` | Python | Reads CSV, rolls unset stats, writes JSON | No |
| `generate_fish.ipynb` | Jupyter | Simulate movement and bite distributions, write CSV | No |

**Pipeline:**
1. Edit `fish_pool.csv` (or run the notebook to tune distributions)
2. Run `python tools/generate_fish_json.py` to produce `project/data/fish_data.json`
3. Godot reads `fish_data.json` via `FileAccess` + `JSON.parse_string()` on startup

### Pond

| File | Format | Purpose | Edit by hand? |
|---|---|---|---|
| `pond_editor.ipynb` | Jupyter | Define vertices, visualize shape, export JSON | Yes — edit `VERTICES` list |
| `pond_data.json` | JSON | Generated output read by Godot at startup | Only for quick tweaks |

**Pipeline:**
1. Edit `VERTICES` in `pond_editor.ipynb` and run all cells to visualize
2. Run the Export cell to write `project/data/pond_data.json`

Godot reads `pond_data.json` and uses the `vertices` array to build the `Polygon2D` node.

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
