# UI Layout

## Screens

### Main Menu
- Game title
- "Start Derby" button
- Settings (timer duration, player name)
- Leaderboard access
- Layout: centered, minimal

### In-Game HUD
- Derby timer (top center or top right)
- Fish caught count (top left or below timer)
- Current catch notification (center, fades after a few seconds)
- Trophy catch notification (center, more prominent)
- Mini-indicator for cast state (casting, waiting, bite!)

### Scoreboard / End of Round
- Shown when derby timer expires
- Player ranking by fish count
- Awards displayed per player
- "Play Again" / "Return to Menu" options
- Trophy catches highlighted

### Leaderboard (Final Game)
- All-time stats
- Sortable by total fish, awards, best round
- Player name and key stats per row

## HUD Element Specs
<!-- For each element, define: position, size, font, colors -->

| Element           | Position    | Size   | Notes              |
|-------------------|-------------|--------|--------------------|
| Derby Timer       | TBD         | TBD    | Countdown format   |
| Fish Count        | TBD         | TBD    | "Fish: 3"          |
| Cast Indicator    | TBD         | TBD    | State text or icon  |
| Catch Popup       | TBD         | TBD    | Fades after 2s     |

## Inkscape Workflow
- Each UI screen as a separate Inkscape file or artboard
- Export dimensions matched to Godot viewport

| Item | Decision | Notes |
|---|---|---|
| Base resolution | TBD | Must match Godot project settings |
| Font | TBD | Must be freely licensed |
| Padding / margin rule | TBD | e.g. 8px or 16px grid |
| Mobile min tap size | TBD | Final game only |

## Responsive / Scaling

| Scope | Strategy | Notes |
|---|---|---|
| Prototype | Fixed resolution | No scaling needed |
| Final Game | TBD | Stretch, letterbox, or viewport scale |
