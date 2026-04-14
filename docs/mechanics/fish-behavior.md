# Fish Behavior

## Spawning
- Fixed number of fish per round (exact count TBD)
- Spawn locations controlled by noise map and/or hand-placed data
- Fish are invisible to the player; no visual indicator of position
- Fish should not all cluster in the same area at spawn time

## Movement Model
- Fish move in discrete "ticks" (not continuous)
- Each tick:
  - Fish chooses a new heading constrained relative to current orientation (e.g., 0 to 140 degrees)
  - Fish darts forward to its new position
- Each fish has its own tick interval (not synchronized)
- Variables to control:
  - Tick frequency range (min/max seconds between moves)
  - Dart distance range
  - Turn angle constraint
  - Speed variation per fish

## Anti-Crowding
- Mechanism to prevent fish from clumping over time
- Options to evaluate:
  - Repulsion force when fish are too close
  - Bias toward less-dense areas
  - Soft boundary zones that redirect movement

## Bite Behavior
- Fish has a bite radius around itself
- When a bobber is within the bite radius, the fish may attempt to bite
- Bite probability factors:
  - Distance from fish to bobber
  - Fish state (recently spooked, recently escaped, idle)
  - Future: lure type
- A fish that escapes a hook can bite again immediately

## Boundary Handling
- Fish must stay within the pond polygon
- When a new heading would move a fish out of bounds, recompute heading
- Fish should not visibly clip or teleport along edges
