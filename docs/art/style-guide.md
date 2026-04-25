# Style Guide

## Art Direction
- Solid colors, minimal detail, recognizable shapes
- Top-down perspective; explore 2.5D depth effect for players
- Hand-made feel without being rough
- Arcade-like, not realistic
- Subtle and simple details (e.g. grass, lillypads, rocks)
- Eventually would go for an artsy-meets-woodsy vibe but keep it very simple for now

## Color Palette
Generally aim for bright and cheerful colors. Subject to change with development, but use these for starting values.

| Element | Color | Hex | Used For |
|---|---|---|---|
| Grass | Green | #35A300 | Ground fill outside the pond |
| Water | Blue | #2CB7D8 | Pond fill |
| Player body | Warm yellow | #F3DB34 | Main torso block |
| Player head | Slightly darker yellow | #D4B820 | Head block; may also indicate facing direction |
| Fishing Rod | Dark Red | #3E090D | Rod from player to rod tip | 
| Fishing line | White | #FFFFFF | Line from rod tip to bobber |
| Bobber top | Red | #DC1717 | Top half of bobber circle |
| Bobber bottom | White | #FFFFFF | Bottom half of bobber circle |
| UI background | Warm wood brown | #7C4A2A | HUD panels, scoreboard background |
| UI text | Cream | #FFF0D0 | All in-game text |

## Pond
- Small hand-made polygon, roughly 8-10 vertices
- Sharp enough to feel hand-drawn, smooth enough to read as a pond
- Green fill outside, blue fill inside
- No shoreline texture for prototype; consider a thin border line

## Player Character
- Rectangular top-down body, wider side-to-side than front-to-back
- Round head, centered side-to-side and offset toward the front of the body
- Facing direction: 4-directional (up / down / left / right); player snaps to cardinal directions on movement
- Rod extends from the front edge of the body, pointing in the facing direction
- Casting arc: forward-facing 150° only (75° each side); cursor positions outside the arc are clamped to the nearest boundary
- Sprite direction: single **facing-up** sprite; Godot rotates it to match the current cardinal direction. One `Sprite2D` rotation per frame is negligible overhead and is the standard approach for this scale of game. Four directional sprites are not needed.

### Character and Element Sizes

| Element | Width | Height | Notes |
|---|---|---|---|
| Player body | 32px | 18px | Landscape rectangle in top-down view; "width" is side-to-side, "height" is front-to-back |
| Player head | 14px diameter | — | Circle; centered side-to-side, offset 2px toward front edge of body |
| Fishing rod | 4px | 28px | Thin rectangle; extends from front edge center in facing direction; rotated in-engine |
| Bobber | 8px diameter | — | Circle, red/white split |
| Fishing line | 1–2px | — | Thin white |

## Fishing Rod and Line
- Rod: thin rectangle extending from the player
- Line: thin white line from rod tip to bobber
- Bobber: small circle, red top half, white bottom half

## Fish (if ever shown)
- Only visible in catch summary or scoreboard, not during gameplay
- Simple silhouette or icon
- Trophy fish get a distinct icon per fish
- If fish move or jump (mechanics tbd), they should give hints as to what kind of fish and size of fish that jumped/made a visible movement. This will be designed as its own feature.

## Animation Notes
- Player movement: snappy, no easing
- Casting: arc motion for the bobber from rod to landing point
- Bobber idle: subtle bob in the water
- Bite indicator: bobber dips below water surface briefly
- Catch: bobber and line retract, brief catch popup

## Asset Pipeline

| Item | Decision | Notes |
|---|---|---|
| Base resolution | **1280×720** | Matches ui-layout.md; set in Godot Project Settings > Display > Window |
| Export format | PNG | Export from Inkscape at 1:1 scale; keep `.svg` as source file |
| Pixel density / scale | 1:1 | No scaling at base resolution; assets drawn at final pixel size |
| Asset naming convention | `snake_case`, prefixed by type | e.g. `icon_fish_standard.png`, `icon_fish_trophy.png`, `sprite_player_body.png`, `icon_bite_alert.png` |
