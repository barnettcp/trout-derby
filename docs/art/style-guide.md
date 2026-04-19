# Style Guide

## Art Direction
- Solid colors, minimal detail
- 2D top-down perspective
- Hand-made feel without being rough
- Arcade-like, not realistic

## Color Palette
<!-- Define hex codes here -->

| Element      | Color  | Hex  |
|-------------|--------|------|
| Grass       | Green  | TBD  |
| Water       | Blue   | TBD  |
| Player body | TBD    | TBD  |
| Fishing line| White  | TBD  |
| Bobber top  | Red    | TBD  |
| Bobber bottom| White | TBD  |
| UI background| TBD   | TBD  |
| UI text     | TBD    | TBD  |

## Pond
- Small hand-made polygon, roughly 8 vertices
- Sharp enough to feel hand-drawn, smooth enough to read as a pond
- Green fill outside, blue fill inside
- No shoreline texture for prototype; consider a thin border line

## Player Character
- Square block person
- Minimal features: maybe eyes or a hat to indicate facing direction
- Holds a simple fishing rod (thin line from hand)

### Character and Element Sizes

| Element | Width | Height | Notes |
|---|---|---|---|
| Player body | TBD px | TBD px | Square block |
| Fishing rod | TBD px | TBD px | Thin rectangle |
| Bobber | TBD px diameter | — | Circle, red/white split |
| Fishing line | 1–2 px | — | Thin white |

## Fishing Rod and Line
- Rod: thin rectangle extending from the player
- Line: thin white line from rod tip to bobber
- Bobber: small circle, red top half, white bottom half

## Fish (if ever shown)
- Only visible in catch summary or scoreboard, not during gameplay
- Simple silhouette or icon
- Trophy fish get a distinct icon per fish

## Animation Notes
- Player movement: snappy, no easing
- Casting: arc motion for the bobber from rod to landing point
- Bobber idle: subtle bob in the water
- Bite indicator: bobber dips below water surface briefly
- Catch: bobber and line retract, brief catch popup

## Asset Pipeline

| Item | Decision | Notes |
|---|---|---|
| Base resolution | TBD | Set in Godot project settings |
| Export format | SVG or PNG per element | UI elements from Inkscape |
| Pixel density / scale | TBD | |
| Asset naming convention | TBD | e.g. `snake_case`, prefix by type |
