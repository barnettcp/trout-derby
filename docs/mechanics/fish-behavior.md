# Fish Behavior

## Spawning

- Fixed number of fish per round
- Spawn locations controlled by noise map and/or hand-placed data
- Fish are invisible to the player
- Fish should not cluster at spawn time

| Variable | Description | Value |
|---|---|---|
| Fish Count | Total fish in the pond per round | TBD |

---

## Movement Model

Fish move in discrete ticks (not continuous). Each tick, a fish chooses a new heading constrained relative to its current orientation, then moves forward to its new position. Movement is instantaneous in the prototype; a ripple animation is deferred to post-prototype.

### Movement Trigger — *Decision Required*

**Option A: Movement Groups**
Fish are assigned to groups that tick in sequential order, cycling back to the first group after the last.

**Option B: Per-Fish Likelihood**
Each fish rolls for movement on every tick.

**Option C: Fixed Ticks Per Fish**
Each fish is assigned a fixed tick interval at spawn. No per-tick randomness.

> **Selected:** TBD

### Movement Variables

| Variable | Description | Min | Max | Notes |
|---|---|---|---|---|
| Tick Interval | Seconds between movement ticks | 5s | 45s | Assigned per fish at spawn |
| Move Distance | Distance traveled per tick | 0.3m | 1.0m | |
| Turn Angle | Max heading change per tick | 0° | 140° | Relative to current orientation |

---

## Anti-Crowding

Prevents fish from clumping over the course of a round.

### Strategy — *Decision Required*

**Option A: Repulsion Force**
Fish push away from each other when too close.

**Option B: Density Bias**
Fish prefer to move toward less-populated areas.

**Option C: Soft Boundary Zones**
Hand-placed zones that redirect fish away from edges or clusters.

> **Selected:** TBD

---

## Bite Behavior

A fish may bite when a bobber is within its bite radius. On a successful bite, the player has a short window to set the hook. A fish that escapes can bite again immediately.

### Bite Variables

| Variable | Description | Value | Notes |
|---|---|---|---|
| Bite Radius | Distance from fish at which it may bite | TBD | |
| Bite Chance | Probability of a bite attempt per tick | TBD | May factor in distance |
| Hook Window | Seconds player has to set the hook | TBD | |

### Bite Probability Factors
- Distance from fish to bobber
- Fish state: idle, recently escaped *(no penalty — can bite again immediately)*
- Future: lure type

---

## Boundary Handling

- Fish must stay within the pond polygon
- When a new heading would move a fish out of bounds, recompute heading
- Fish should not clip or teleport along edges
