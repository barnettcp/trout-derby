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

> **Tiebreaker rule:** If players tie (only applicable to Longest or Heaviest), the score modifier is given equally to all players who are tying. This means sharing an achievement is to be celebrated together rather than leaving regret for not being an outright winner.

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
3. Scoreboard displayed with rankings and awards
4. Transition to next round or lobby
