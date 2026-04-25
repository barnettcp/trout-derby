# UI Layout

## Screens

### Main Menu
- Game title / logo centered
- **"Join Derby"** — primary button
- **"Exit"** — secondary button
- Settings (timer duration, player name) — accessible from this screen
- Leaderboard access (final game)
- Layout: centered, minimal

### In-Game HUD
- **Derby timer** (top center) — Silkscreen countdown, always visible
- **Score box** (top left) — fish count label + icon grid filling left to right, 5 per row; trophy catches use a gold icon variant
- **Cast power bar** (world-space, near player) — hold-to-charge fill bar appears when player holds cast; fills left to right green → yellow → red; disappears on release and bobber launches
- **Bite alert** (world-space, near bobber) — yellow spiked burst icon appears when fish bites; fades over 1s; player must set hook within the hook window
- **Catch popup** (left center, HUD) — appears after a successful catch; shows a fish portrait (centered top), species, length, weight, rounds since last caught, and a “TROPHY” badge if applicable; fades after 2s

### Scoreboard / End of Round
- Appears when the derby timer expires
- Player ranking by fish count; awards displayed per player; trophy catches highlighted
- A **1-minute countdown** to the next derby starts immediately when the scoreboard appears
- Player can press a button to **dismiss** the summary and walk around the pond while waiting
- Scoreboard **auto-closes** when 10 seconds remain until the next derby starts
- Prototype: loops back to a new derby automatically after the countdown

### Leaderboard (Final Game)
- All-time stats
- Sortable by total fish, awards, best round
- Player name and key stats per row

## Scene Flow (Prototype)

```
Game loads
  └─ Main Menu
       └─ Player presses "Join Derby"
            └─ 10-second countdown overlay
                 └─ Derby begins — in-game HUD visible, timer counts down
                      └─ Timer expires
                           └─ Scoreboard / summary appears
                                ├─ 1-minute countdown to next derby begins
                                ├─ Player can dismiss summary → walks around pond
                                └─ Summary auto-closes at 10 s remaining
                                     └─ Next derby begins (loops)
```

| Transition | Method | Notes |
|---|---|---|
| Menu → Countdown | Overlay / scene change | 10 s countdown centered on screen |
| Countdown → Derby | Overlay dismisses, HUD becomes active | Derby timer starts |
| Derby → Scoreboard | Scene change or overlay | Active fishing lines resolved first |
| Scoreboard → Next Derby | Auto at 10 s remaining or on dismiss | Player stays in world between derbies |

## HUD Element Specs

All measurements in pixels at base resolution 1280×720. Fixed HUD elements live on a `CanvasLayer` node. World-space elements live in the main scene and are positioned relative to game objects.

### Fixed HUD (CanvasLayer)

| Element | Position | Size | Font | Colors | Notes |
|---|---|---|---|---|---|
| Derby Timer | Top center — x=640, y=16; anchor: top-center | 200×56 | Silkscreen Bold, 40px | bg `#7C4A2A`, text `#FFF0D0` | Countdown MM:SS format |
| Score Box | Top left — x=16, y=16 | 160×auto | Silkscreen Regular, 14px | bg `#7C4A2A`, text `#FFF0D0` | "Fish: 3" count label at top; icons 20×20px, 5 per row, 4px gap; gold icon for trophy catches; starts at 2 rows (10 slots); a new row of 5 appends automatically for each additional 5 fish caught |
| Catch Popup | Left center — x=16, y=296 | 280×216 | Fredoka Medium 18px (headline), Silkscreen Regular 14px (stats) | bg `#7C4A2A`, text `#FFF0D0` | Portrait (~120×80) centered at top with 8px padding; species name below; stats: length, weight, rounds since last caught; “TROPHY” badge if applicable; fades out after 2s; fixed position for prototype — if score box grows tall enough to overlap, revisit as dynamic offset below score box bottom + 8px gap |

### World-Space Elements (Main Scene)

| Element | Position | Size | Colors | Notes |
|---|---|---|---|---|
| Cast Power Bar | 12px above player center, horizontally centered | 64×10 + 2px border | Fill: `#35A300` → `#F3DB34` → `#DC1717` | Appears on cast hold; fills left to right; color transitions green → yellow → red as bar fills; disappears on release |
| Bobber | World-space; placed at landing point | 8px diameter | Top `#DC1717`, bottom `#FFFFFF` | Red/white split circle; drawn in Inkscape, imported as `Texture2D`; Godot scales it via sine curve during cast arc (peaks at 1.5× at midpoint) |
| Bite Alert | 16px above bobber center | 32×32 | `#F3DB34` | Spiked burst / comic explosion icon; appears on bite event; fades over 1s |

## Inkscape Workflow
- Each UI screen as a separate Inkscape file or artboard
- Export dimensions matched to Godot viewport (1280×720)

### What Goes Where

**Rule of thumb: if it changes at runtime, build it in Godot. If it's a static picture, draw it in Inkscape.**

| Asset | Tool | Reason |
|---|---|---|
| Fish icon (standard) | Inkscape | Static image, imported as `Texture2D` |
| Fish icon (trophy / gold variant) | Inkscape | Static image, imported as `Texture2D` |
| Bite alert burst icon | Inkscape | Static image; Godot animates scale/fade via tween |
| Player sprite | Inkscape | Static image |
| Fish sprites | Inkscape | Static images (hidden at runtime; fish are invisible in prototype) |
| Fish portraits (species + trophy) | Inkscape | Static images shown in catch popup |
| Game logo / title art | Inkscape | Static image |
| Button / panel backgrounds | Godot (`StyleBoxFlat`) | Simple shapes; no need to leave Godot |
| Derby timer label | Godot (`Label`) | Updates every second |
| Score count label | Godot (`Label`) | Updates on each catch |
| Score icon grid | Godot (`GridContainer`) | Populated at runtime; uses fish icon texture |
| Catch popup text | Godot (`Panel` + `Label`) | Dynamic content, fade tween |
| Cast power bar | Godot (`TextureProgressBar` or `draw_rect`) | Driven by hold duration |
| Bobber sprite | Inkscape | Static image; Godot positions it in world-space and drives scale during cast arc |
| Bite alert animation | Godot (`Sprite2D` + tween) | Godot handles scale-in and fade-out |
| Pond shape | Godot (`Polygon2D`) | Collision and color defined in engine |
| Grass / background | Godot (`ColorRect` or `Polygon2D`) | Simple flat color |

| Item | Decision | Notes |
|---|---|---|
| Base resolution | **1280×720** | 16:9; set in Godot Project Settings > Display > Window |
| Stretch mode | `canvas_items` | Scales all nodes uniformly |
| Stretch aspect | `keep` | Letterboxes rather than stretches; simple and predictable |
| Safe zone margin | 16px from all edges | Accounts for browser chrome and iframe borders |
| Font | Silkscreen for headings and scoreboards, Fredoka for UI | Vary font size and boldness. Consider using Fredoka's variable font in Godot. |
| Padding / margin rule | 16px grid | Consistent spacing unit |
| Mobile min tap size | TBD | Final game only — revisit when switching aspect to `expand` |

## Responsive / Scaling

| Scope | Strategy | Notes |
|---|---|---|
| Prototype | Fixed 1280×720, `keep` aspect | Letterbox on large screens; fine for local + itch.io |
| Final Game | Switch to `expand` aspect + safe area margins | Required for mobile portrait/landscape handling |
