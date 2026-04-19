# Scoring

## Derby Round

Round ends when the timer expires. In the prototype, the round begins when the player enters. In the final game, rounds run on a fixed server schedule.

| Variable | Description | Value | Notes |
|---|---|---|---|
| Round Duration | Length of a derby in seconds | TBD | 2 or 5 minutes for prototype |

---

## Score Calculation

Primary score is total fish caught.

### Score Modifiers — *Decision Required*

| Modifier | Description | Include in Prototype? |
|---|---|---|
| Longest fish bonus | Extra points for the longest catch | TBD |
| Heaviest fish bonus | Extra points for the heaviest catch | TBD |
| Trophy fish bonus | Extra points for catching a trophy | TBD |

> **Tiebreaker rule:** TBD

---

## Awards

Awards are given at the end of each derby and persist across rounds.

| Award | Condition | Notes |
|---|---|---|
| Most Fish | Player with the highest fish count | |
| Biggest Catch | Longest or heaviest single fish | TBD which metric |
| Trophy Catch | Catching the derby's trophy fish | |

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
