# Fish Behavior

## Spawning

- Fixed number of fish per round
- Spawn locations controlled by noise map and/or hand-placed data
- Fish are invisible to the player
- Fish should not cluster at spawn time

| Variable | Description | Value |
|---|---|---|
| Fish Count | Total fish in the pond per round | 120 |

---

## Movement Model

Fish move in discrete ticks (not continuous). Each tick, a fish chooses a new heading constrained relative to its current orientation, then moves forward to its new position. Movement is instantaneous in the prototype; a ripple animation is deferred to post-prototype.

### Movement Trigger — *Decided*

Each fish has its own independent `Timer` node. On timeout, the fish moves, then the timer restarts. Interval is a pre-rolled attribute stored on each fish, generated in `generate_fish.ipynb` and loaded from `fish_data.json`.

At 120 fish this is negligible overhead, and it allows per-fish personality variation (lazy vs. active fish) as a natural extension later.

> **Selected:** Per-fish independent timer. Interval is a fish attribute assigned at spawn.

### Movement Variables

| Variable | Description | Min | Max | Notes |
|---|---|---|---|---|
| Movement Tick Interval | Seconds between movement ticks | 4s | 30s | Pre-rolled attribute on each fish; stored in `fish_data.json` |
| Move Distance | Distance traveled per tick | 0.3m | 1.0m | |
| Turn Angle | Max heading change per tick | 0° | 110° | Relative to current orientation |

*Movement and bite detection run on separate timers. Bite checks use a faster global timer so the player gets a responsive feel regardless of a fish's movement interval.*

---

## Anti-Crowding

Prevents fish from clumping over the course of a round.

### Strategy — *Decided*

**Option A: Repulsion Force**
Fish push away from each other when too close. Every tick, each fish checks proximity to all other fish (or fish within a spatial grid partition). A repulsion vector is added to the movement direction.

**Option B: Density Bias**
Fish prefer to move toward less-populated areas. At tick time, you check a couple of candidate directions, count nearby fish in each cone, and weight the random heading choice.

**Option C: Soft Boundary Zones**
Hand-placed zones that redirect fish away from edges or clusters. The logic per tick is simple (am I in a zone? bias heading inward).

> **Selected:** Option A. This feels like it could be made to be more organic through tuning and is not wildly difficult to implement.

### Anti-Crowding Variables

| Variable | Description | Value |
|---|---|---|
| Repulsion Radius | Distance within which fish push each other away | 2m |
| Repulsion Strength | Influence weight of the repulsion vector (0 = none, 1 = strong) | 0.5 |

---

## Bite Behavior

A fish may bite when a bobber is within its bite radius. On a successful bite, the player has a short window to set the hook. A fish that escapes can bite again immediately.

### Bite Variables

Bite check interval is a **pre-rolled attribute** stored on each fish, giving each fish a distinct personality (eager vs. patient).

| Variable | Description | Value | Notes |
|---|---|---|---|
| Bite Check Interval | Seconds between bite proximity checks | Gamma(α=2, θ=3), min 2s | Pre-rolled attribute on each fish; mean ~6s, mode ~3s; stored in `fish_data.json` |
| Bite Radius | Distance from fish at which it may bite | 1m | |
| Bite Chance | Probability of a bite attempt per check | 100% within 0.2m, linearly scales down to 20% at edge of radius | Distance factors in |
| Hook Window | Seconds player has to set the hook | 1 second | |

### Bite Probability Factors
- Distance from fish to bobber
- Fish state: idle, recently escaped *(prototype: no penalty — can bite again immediately)*
- Future: lure type

---

## Boundary Handling

- Fish must stay within the pond polygon
- When a new heading would move a fish out of bounds, recompute heading
- Fish should not clip or teleport along edges
