# Asset Checklist

All assets are drawn in Inkscape and exported as PNG at 1:1 scale (96 DPI). Confirm your Inkscape document is set to 96 DPI (File > Document Properties > Display Units: px) so that 1 Inkscape px = 1 Godot pixel. Export each asset via **File > Export PNG Image > Selection** and verify the pixel dimensions match before exporting.

Name files using `snake_case` with a type prefix per the [Style Guide](style-guide.md).

---

## Icons

### `icon_fish_standard.png` — 20×20 px
- [x] Closed-path fish silhouette in a single flat color — cream `#FFF0D0` reads well against the brown HUD panel
- [ ] Optional: tiny dot eye; skip if it looks muddy at 20px
- [x] Enable 1px pixel grid (View > Show/Hide > Page Grid) and snap to grid so edges land on whole pixels — prevents blurring on import

---

### `icon_fish_trophy.png` — 20×20 px
- [x] Same silhouette shape as `icon_fish_standard`; recolor fill to gold `#F3DB34`
- [ ] Optional subtle star or sparkle overlay to distinguish it at a glance — keep it readable at 20px
- [x] Export as a separate file (not a layer toggle)

---

### `icon_bite_alert.png` — 32×32 px
- [x] Starburst / comic-explosion shape: central circle with 6–8 pointed spikes radiating outward; keep spikes fat enough to read at 32px
- [x] Solid fill `#F3DB34`; no outline needed — a clean silhouette reads better on varied backgrounds
- [x] Leave 1–2px of transparent padding inside the 32×32 canvas so Godot's scale-in tween doesn't clip the edges
- [ ] Godot handles all animation (scale and fade); this is a static image only

---

## Sprites

### `sprite_player.png` — ~32×18 px canvas
For the prototype, make one **facing-up** sprite and let Godot rotate it. Four directional sprites can be revisited later.

- [x] Body: 32×18 px landscape rectangle, warm yellow `#F3DB34`
- [x] Head: 14px-diameter circle, slightly darker yellow `#D4B820`; centered horizontally, offset 2px toward the top (front) edge of the body
- [n/a] Transparent background; canvas tall enough to contain body + rod without clipping
- [ ] If you later go with 4 directional sprites, rename to `sprite_player_up.png`, `sprite_player_down.png`, etc.

---

### `sprite_fishing_rod.png` — 4×28 px
Keeping the rod separate from the player sprite lets Godot rotate it independently for casting direction.

- [x] Rod: 4×28 px dark-red rectangle (`#3E090D`) extending upward from the top-center of the body — either include it here or export it as a separate file (see below); separate is more flexible
- [x] At 4px wide, snap coordinates to whole pixels and disable anti-aliasing on the path to avoid blurring on export
- [x] Transparent background

---

### `sprite_bobber.png` — 8×8 px
The bobber that sits in the water after a cast. Godot positions it in world-space and drives its scale during the cast arc.

- [x] 8px-diameter circle — top half `#DC1717` (red), bottom half `#FFFFFF` (white)
- [x] Draw two filled semicircles sharing a flat edge across the center; a 1px dark dividing line (`#3E090D`) between halves reads well at this size
- [x] Transparent background; canvas is exactly 8×8 px
- [x] Snap to pixel grid — at 8px any sub-pixel edge will visibly blur on import
- [ ] Godot handles all animation (cast arc scale, idle bob, dip on bite); this is a static image only

---

## UI / Branding

### Game logo / title art — width 600x300 px
- [x] Lay out "Trout Derby" using Fredoka or Silkscreen font
- [x] Convert text to path: **Path > Object to Path** — removes font dependency in Godot
- [x] Add a simple decorative element (fish silhouette, water-ripple line, etc.) to give it character
- [x] Transparent background if entire image is not used; canvas is exactly 600x300px
- [x] Export at the finalized width; name `logo_title.png`

---

## Fish Portraits

Small illustrations shown in the catch popup, centered above the fish's stats. Suggested size ~120×80 px to fit the 280×216 popup panel. Trophy fish use their own unique portrait (see Trophy Fish Portraits below); standard catches display the species portrait.

### `icon_rainbow_trout.png`
- [x] Rainbow trout silhouette
- [x] Reasonably realistic colors
- [x] A few small spots on back and tail

---

## Trophy Fish Portraits (low priority — placeholder rects are fine for the first pass)

Unique portraits shown in the catch popup in place of the standard species portrait when a trophy fish is caught. Suggested size ~120×80 px to fit the 280×216 popup panel.

### `icon_trophy_scruffy.png`
- [ ] Rainbow trout silhouette with a tiny drawn-on moustache (`#3E090D`)
- [ ] Transparent background

### `icon_trophy_sally.png`
- [ ] Yellow/brown trout silhouette with a small bow or collar shape
- [ ] Transparent background

### `icon_trophy_smokey.png`
- [ ] Brook trout silhouette with a tiny pipe
- [ ] Transparent background

---

## Asset Summary

| File | Size | Status |
|---|---|---|
| `icon_fish_standard.png` | 20×20 | prototype done |
| `icon_fish_trophy.png` | 20×20 | prototype done |
| `icon_bite_alert.png` | 32×32 | prototype done |
| `sprite_player.png` | 32×18 | prototype done |
| `sprite_fishing_rod.png` | 4×28 | prototype done |
| `sprite_bobber.png` | 8×8 | prototype done |
| `logo_title.png` | ~400–600 wide | prototype done |
| `icon_rainbow_trout.png` | ~120×80 | prototype done |
| `icon_trophy_scruffy.png` | ~120×80 | - |
| `icon_trophy_sally.png` | ~120×80 | - |
| `icon_trophy_smokey.png` | ~120×80 | - |
