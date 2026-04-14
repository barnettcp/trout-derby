# Fishing Mechanics

## Casting
- Player aims with cursor (sets direction from character)
- Cast initiated with a key/click
- Cast distance determined by a timing mechanic (hold and release)
  - Minimum distance: just past the shore
  - Maximum distance: center of the pond
- Cast must land in water; casts that land on land fail gracefully
- Bobber lands at the computed point; line drawn from rod tip to bobber

## Waiting for a Bite
- Bobber sits in the water at the cast location
- Fish within a bite radius of the bobber may attempt to bite
- Bite chance influenced by proximity of fish to bobber
- Visual/audio cue when a fish bites (bobber dip, sound)

## Setting the Hook
- Player has a short reaction window to click/press after the bite cue
- Successful hook: fish is caught, removed from the pond
- Missed hook: fish escapes but can bite again immediately (no cooldown)

## Reeling
- Minimal reeling mechanic for prototype
- Consider expanding for final game (fish fight, tension, etc.)

## Edge Cases
- Player moves while line is cast: what happens?
- Player casts while already casting: ignored or cancels?
- Bobber lands exactly on the shoreline polygon edge
