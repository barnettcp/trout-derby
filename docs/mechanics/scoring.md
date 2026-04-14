# Scoring

## Derby Round
- Each round has a configurable timer (2 or 5 minutes for prototype)
- Round begins when the player enters the game (prototype) or on a server schedule (final game)
- Round ends when the timer expires

## Score Calculation
- Primary score: total number of fish caught
- Potential modifiers (TBD):
  - Longest fish bonus
  - Heaviest fish bonus
  - Trophy fish bonus points
- Tiebreaker rules if scores are equal

## Awards
- Awards given at end of each derby
- Award types to define:
  - Most fish caught
  - Biggest catch (length or weight)
  - Trophy catch
- Awards persist across rounds for each player

## Persistence Without Accounts
- No account creation required
- Prototype: local storage
- Final game: browser local storage or cookie-based identity
- Player identity: self-chosen name or generated identifier
- Risk: data loss on device/browser change (acceptable for scope)

## End-of-Round Flow
- Timer expires
- All active fishing lines are resolved or cancelled
- Scoreboard displayed with rankings and awards
- Transition to next round or lobby
