# Fishing Mechanics

## Casting

Player aims with the cursor (direction only, not target location). Cast distance is controlled by a hold-and-release power bar. The bobber lands at the computed point; a line is drawn from the rod tip to the bobber. Casts that land on land fail gracefully.

### Casting Variables

| Variable | Description | Value | Notes |
|---|---|---|---|
| Min Cast Distance | Closest valid landing point | TBD | Just past the shore |
| Max Cast Distance | Farthest valid landing point | TBD | Roughly center of pond |
| Power Bar Speed | How fast the bar fills | TBD | |

---

## Waiting for a Bite

Bobber sits in the water. Fish within bite radius may attempt to bite. Visual and audio cue on bite (bobber dip + sound). The player may recall their bobber at any time. Reeling this in takes a brief delay, initially set at 0.5 seconds.

---

## Setting the Hook

Player has a short reaction window after the bite cue. Successful hook removes the fish from the pond. Missed hook releases the fish with no cooldown.

---

## Reeling

### Prototype Reeling — *Decided*

**Option A — No reeling**
Hook = catch. Fish is immediately landed.

**Option B — Single input**
Player holds a button briefly to reel in. No tension mechanic.

> **Selected:** Option B. The reeling process should take 1 second to begin with.

*Full fish-fight reeling is deferred to post-prototype.*

---

## Edge Cases — *Decisions Required*

| Situation | Behavior | Decision |
|---|---|---|
| Player moves while line is cast | Cancel cast? Lock movement? | Movement is locked until the player cancels their cast |
| Player casts while already casting | Ignore input or cancel current cast | Ignore input until bobber lands in the water |
| Bobber lands on shoreline edge | Treat as land (fail) or water (valid) | Treat as land (fail) |
