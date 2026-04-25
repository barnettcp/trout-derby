# Fish Catalog

## Standard Fish

All standard fish are trout. Length is normally distributed; weight is derived from length using a power law. Fish are persistent across rounds — returned to the pond after each derby with their catch history intact.

### Standard Fish Attributes

| Attribute | Distribution | Mean | Std Dev | Notes |
|---|---|---|---|---|
| Length | Normal | 12 in | 2 in | Manually add a few bigger/smaller ones as needed |
| Weight | Power law: `a × length^b` | ~0.74 lb at 12 in | ±8% noise (multiplicative) | `a=0.00043`, `b=3.0`; generates naturally heavier fish at longer lengths |
| Rounds Since Caught | Tracked | — | — | Persisted across rounds; 0 if caught this round |

## Trophy Fish
For replayability, randomness, and expandability, there will be trophy fish included inthe game. The team must be able to easily add additional trophy fish. The long-term goal will be to keep these fresh and fun, with a few placeholders created for the prototype. Players will not know which trophy fish is in the pond, but all of them will be able to see when the trophy fish was caught by someone, through a small golden fish icon.

- 3 trophy fish defined for initial prototype
- Each derby, one of the available trophy fish is selected
- Each trophy fish has:
  - Unique name
  - Minimal backstory (one or two sentences)
  - Distinct icon (different from standard fish)
  - Exceptional length/weight values
- Catching a trophy fish grants the player a title. The title will go after the player's chosen name.

## Trophy Fish Roster
This should be a list that grows over time with interest and ideas. Prototype through final game is just fine to only have these three. Get creative with them as part of development.

| Name | Description | Length | Weight | Notes | Title Gained |
|------|-------------|--------|--------|-------| -------------|
| Scruffy the Cleanly | A large ranbow trout | 25.9in    | 7.8lb    | He's got a moustache!   | the Cleanly |
| Sally the Civilized | A yellow/brown trout | 23.2in | 6.2lb | She's beautiful! Look at that dress! | the Civilized |
| Old Smokey the Wise | A wise old brook trout | 22.2in | 6.0lb | How did he even light that pipe? | the Wise |

## Future Considerations
- Additional species beyond trout
- Seasonal or weather-based fish variation
- Lure preferences per fish type
