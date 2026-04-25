# Scoring

## Derby Round

Round ends when the timer expires. In the prototype, the round begins when the player enters. In the final game, rounds run on a fixed server schedule.

| Variable | Description | Value | Notes |
|---|---|---|---|
| Round Duration | Length of a derby in seconds | 5 minutes | 2 or 5 minutes for prototype |

---

## Score Calculation

Primary score is total fish caught.

### Score Modifiers — *Decided*

| Modifier | Description | Include in Prototype? | Score |
|---|---|---|---|
| Longest fish bonus | Extra points for the longest catch | Yes | +1 |
| Shortest fish bonus | Extra points for the shortest catch | Yes | +1 |
| Heaviest fish bonus | Extra points for the heaviest catch | Yes | +1 |
| Trophy fish bonus | Extra points for catching a trophy | Yes | +3 |

> **Tiebreaker rule:** If players tie (only applicable to Longest, Shortest, or Heaviest), the score modifier is given equally to all players who are tying. This means sharing an achievement is to be celebrated together rather than leaving regret for not being an outright winner.

---

## Awards

Awards are given at the end of each derby and persist across rounds.

| Award | Condition | Award Given |
|---|---|---|
| Most Fish | Player(s) with the highest fish count | A gold star |
| Biggest Catch | Longest single fish | A blue ribbon |
| Trophy Catch | Catching the derby's trophy fish | A small trophy |

---

## Persistence Without Accounts

No account creation required. Player identity is self-chosen name.

| Scope | Storage Method | Notes |
|---|---|---|
| Prototype | Godot `ConfigFile` / local file | |
| Final Game | Browser localStorage (JSON) | Risk: lost on device/browser change — acceptable |

---

## End-of-Round Flow

1. Timer expires
2. All active fishing lines are resolved or cancelled
3. Scoreboard / summary screen appears with rankings and awards
4. A **1-minute countdown** to the next derby begins immediately
5. Player may dismiss the summary at any time and walk around the pond while waiting
6. Summary **auto-closes** when 10 seconds remain until the next derby
7. Next derby begins (loops back to step 1)
