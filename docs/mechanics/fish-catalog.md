# Fish Catalog

## Standard Fish

All standard fish are trout. Each fish rolls its own length and weight at spawn from a normal distribution. Fish are persistent across rounds — returned to the pond after each derby with their catch history intact.

### Standard Fish Attributes

| Attribute | Distribution | Mean | Std Dev | Notes |
|---|---|---|---|---|
| Length | Normal | 12 in | 2 in | Manually add a few bigger/smaller ones as needed |
| Weight | Normal | 0.05 lbs/in | 0.01 lbs/in | Pounds per inch. Simulate, then apply to fish length  |
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
This should be a list that grows over time with interest and ideas. Prototype through final game is just fine to only have these three.

| Name | Description | Length | Weight | Notes | Title Gained |
|------|-------------|--------|--------|-------| -------------|
| Scruffy the Cleanly | A large ranbow trout | TBD    | TBD    | He's got a moustache!   | the Cleanly |
| Sally the Civilized | A yellow/brown trout | TBD | TBD | She's beautiful! Look at that dress! | the Civilized |
| Old Smokey the Wise | A wise old brook trout | TBD | TBD | How did he even light that pipe? | the Wise |

## Future Considerations
- Additional species beyond trout
- Seasonal or weather-based fish variation
- Lure preferences per fish type
