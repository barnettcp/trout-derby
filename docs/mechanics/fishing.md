# Fishing Mechanics

## Casting

Player aims with the cursor (direction only, not target location). Cast distance is controlled by a hold-and-release power bar. The bobber lands at the computed point; a line is drawn from the rod tip to the bobber. Casts that land on land fail gracefully.

### Facing and Casting Arc

The player faces one of four cardinal directions (up / down / left / right) and can only cast within a **150° forward arc** — 75° to either side of the facing direction. Cursor positions outside this arc are clamped to the nearest arc boundary. This prevents side-to-side casts and keeps the facing direction meaningful.

### Cast Input

| Action | Input |
|---|---|
| Charge cast | Hold left-click **or** hold Space |
| Fire cast | Release the held input |
| Recall bobber (cancel, no hook set) | Single left-click **or** Space — 0.5 s cooldown before next cast |
| Set hook (during bite window) | Single left-click **or** Space |

### Casting Variables

All distances stated in meters. Pixel equivalents use the world scale of **15 px/m** (see [Architecture](../technical/architecture.md)).

| Variable | Description | Value | Pixels (15 px/m) | Notes |
|---|---|---|---|---|
| Min Cast Distance | Closest valid landing point | 5 m | 75 px | Just past the shore |
| Max Cast Distance | Farthest valid landing point | 18 m | 270 px | Center of pond reachable from shoreline |
| Power Bar Speed | Time for bar to fill from 0% to 100% | 1 s | — | Linear fill; releasing at any point fires at that power |

### Bobber Arc Animation

The bobber travels in a simulated parabolic arc from the rod tip to the landing point.

| Variable | Description | Value | Notes |
|---|---|---|---|
| Cast Travel Duration | Time for bobber to reach landing point | 0.5 s | Variable; tune for feel |
| Arc Scale Peak | Bobber scale at arc midpoint | 1.5× | Driven by `sin(t × π)` where t = 0→1 over cast duration; simulates z-height in top-down view |

**Implementation note:** Two parallel `Tween` tracks run simultaneously — one lerps position from rod tip to landing point, the other drives scale using a sine curve. Scale peaks at midpoint (t = 0.5) and returns to 1.0 at landing. No shadow is needed for the prototype.

---

## Waiting for a Bite

Bobber sits in the water. Fish within bite radius may attempt to bite. Visual and audio cue on bite (bobber dip + sound). The player may recall their bobber at any time. Reeling this in takes a brief delay, initially set at 0.5 seconds.

---

## Setting the Hook

Player has a short reaction window after the bite cue. **Input: single left-click or Space bar.** Successful hook removes the fish from the pond. Missed hook releases the fish with no cooldown.

| Variable | Value |
|---|---|
| Hook Window | 1 second |

---

## Reeling

### Prototype Reeling — *Decided*

**Option A — No reeling**
Hook = catch. Fish is immediately landed.

**Option B — Single input**
Player holds a button briefly to reel in. No tension mechanic.

> **Selected:** Option B. After a successful hook-set, reeling happens **automatically** over **2 seconds** — no additional player input required. A catch popup appears when complete.

*Full fish-fight reeling is deferred to post-prototype.*

---

## Edge Cases — *Decided*

| Situation | Behavior | Decision |
|---|---|---|
| Player moves while line is cast | Cancel cast? Lock movement? | Movement is locked until the player cancels their cast |
| Player casts while already casting | Ignore input or cancel current cast | Ignore input until bobber lands in the water |
| Bobber lands on shoreline edge | Treat as land (fail) or water (valid) | Treat as land (fail) |
| Player wants to cancel without firing | What input cancels a held cast? | Not allowed — the cast fires on release. Once the bobber is in the water, single left-click or Space recalls it; 0.5 s cooldown before next cast. |
