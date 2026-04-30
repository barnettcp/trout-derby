# Project Checklist

High-level progress tracker from initial design through prototype launch. Items are grouped by phase; sub-items are representative tasks, not exhaustive. See linked docs for full task lists.

Polish and art refinement are deliberately deferred — the goal of the prototype phase is a working fishing loop, not polished visuals.

---

## Phase 1 — Documentation

- [x] Game design document
- [x] Mechanics — fishing, fish behavior, fish catalog, scoring
- [x] Technical — architecture, data models, multiplayer (future)
- [x] Art — style guide, UI layout, asset checklist
- [x] Milestones — prototype, final game

---

## Phase 2 — Data Pipeline

- [x] Fish pool CSV authored (`tools/fish_pool.csv`)
- [x] Fish JSON generator script (`tools/generate_fish_json.py`)
- [x] Fish data generated (`project/data/fish_data.json`)
- [x] Pond editor notebook (`tools/notebooks/pond_editor.ipynb`)
- [x] Pond data generated (`project/data/pond_data.json`)

---

## Phase 3 — First-Pass Art Assets

*All prototype assets built. Sharpness and style polish deferred to post-prototype housekeeping, likely in Aseprite.*

- [x] `icon_fish_standard.png` — 20×20 HUD fish icon
- [x] `icon_fish_trophy.png` — 20×20 HUD fish icon (gold)
- [x] `icon_bite_alert.png` — 32×32 bite burst icon
- [x] `sprite_player.png` — 32×18 player body + head
- [x] `sprite_fishing_rod.png` — 4×28 rod
- [x] `sprite_bobber.png` — 8×8 bobber
- [ ] `logo_title.png` — title art (not needed to begin Godot work)
- [x] Fish portraits — `icon_rainbow_trout.png` + trophy variants (`icon_trophy_scruffy.png`, `icon_trophy_sally.png`, `icon_trophy_smokey.png`) — 120×80 px, transparent backgrounds

---

## Phase 4 — Godot Project Setup

- [ ] Initialize Godot 4 project in `project/`; configure base resolution 1280×720, stretch mode `canvas_items`, aspect `keep`
- [ ] Set up autoloads — `game_state.gd`, `config.gd`
- [ ] Import fonts (Fredoka, Silkscreen) and art assets
- [ ] Stub out scene files and folder structure per architecture doc

---

## Phase 5 — Pond and Environment

- [ ] Create pond `Polygon2D` from `pond_data.json` vertices
- [ ] Green grass background (`ColorRect`), blue water fill
- [ ] Collision boundary — player and fish cannot leave/enter pond respectively

---

## Phase 6 — Player

- [ ] `player.tscn` — sprite, collision shape, movement script
- [ ] WASD / arrow key movement at 17 px/s, 4-directional snap
- [ ] Spawn at fixed position near top-left, facing pond
- [ ] Collision with pond boundary (player cannot enter water)

---

## Phase 7 — Fishing Rod and Bobber

- [ ] Rod sprite attached to player, rotates to face cursor direction within 150° arc
- [ ] Cast power bar (hold to charge, release to fire) — built in Godot, no art asset needed
- [ ] Bobber arc animation (sine-driven scale over 0.5 s travel)
- [ ] Bobber placement validates water landing; fails gracefully on land
- [ ] Fishing line drawn from rod tip to bobber
- [ ] Recall input (single click / Space, 0.5 s cooldown)

---

## Phase 8 — Fish System

- [ ] Load `fish_data.json` at startup; instantiate fish nodes
- [ ] Fish invisible to player
- [ ] Tick-based movement with per-fish timer interval
- [ ] Pond boundary containment for fish
- [ ] Anti-crowding repulsion
- [ ] Bite proximity check and bite roll
- [ ] Trophy fish spawning (one per derby)

---

## Phase 9 — Catch Loop

- [ ] Bite cue — `icon_bite_alert.png` appears above bobber, fades over 1 s; bite sound
- [ ] Hook window — 1 s reaction window on input (click / Space)
- [ ] Successful hook → auto-reel over 2 s → fish removed from pond
- [ ] Catch popup — portrait placeholder, species, length, weight, rounds since last caught, TROPHY badge
- [ ] Fish added to player score

---

## Phase 10 — Derby and UI

- [ ] Main menu scene — Join Derby button, settings (timer duration, player name)
- [ ] Derby timer — configurable 2 or 5 min; 10 s pre-derby countdown overlay
- [ ] In-game HUD — timer, score box with fish icon grid
- [ ] End-of-round scoreboard — rankings, awards (most fish, biggest catch, trophy catch)
- [ ] 1-minute between-derby countdown; dismissible; auto-close at 10 s remaining
- [ ] Score modifiers applied (longest, shortest, heaviest, trophy)

---

## Phase 11 — Audio

- [ ] Cast sound
- [ ] Bite indicator sound
- [ ] Catch sound
- [ ] Round end sound

---

## Phase 12 — Prototype Polish and Testing

- [ ] Play-test full fishing loop end to end
- [ ] Tune fish movement tick intervals, bite rates, and fish count for feel
- [ ] Verify HUD layout at 1280×720; check score box overflow behavior
- [ ] Fix any collision, input, or timing edge cases
- [ ] Accept blurry art as-is; note sharpness pass as post-prototype task

---

## Phase 13 — Export to itch.io

- [ ] Configure Godot HTML5 export template
- [ ] Test in browser (Chrome / Firefox) at target resolution
- [ ] Set up itch.io project page and upload build
- [ ] Smoke-test live build

---

## Deferred — Post-Prototype

- Art sharpness pass (Aseprite) — icons, sprites
- Explore art style variants for player character
- Expanded color palette
- Multiplayer / server infrastructure
- Mobile / `expand` aspect ratio
- Possible 3D version exploration
