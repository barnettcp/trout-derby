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
| Base resolution | TBD | Set in Godot project settings |
| Export format | SVG or PNG per element | UI elements from Inkscape |
| Pixel density / scale | TBD | |
| Asset naming convention | TBD | e.g. `snake_case`, prefix by type |
