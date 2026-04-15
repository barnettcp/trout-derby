# Fish Catalog

## Standard Fish
- All standard fish are trout (species details TBD)
- Attributes:
  - Length (normally distributed around a center value)
  - Weight (normally distributed, correlated with length)
  - Rounds since last caught (tracked per fish, persisted across rounds)
- Center values and standard deviations to be defined
- Each fish instance rolls its own length/weight at spawn
- Fish are persistent entities across rounds; they are returned to the pond after each derby and their catch history carries forward

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
<!-- Define each trophy fish here -->

| Name | Description | Length | Weight | Notes | Title Gained |
|------|-------------|--------|--------|-------| -------------|
| Scruffy  | A large ranbow trout | TBD    | TBD    | He's got a moustache!   | the Cleanly |
| Sally | A yellow/brown trout | TBD | TBD | She's beautiful! | the Civilized |
| Old Smokey | A brook trout | TBD | TBD | Look at those spots! | the Spotted |

## Future Considerations
- Additional species beyond trout
- Seasonal or weather-based fish variation
- Lure preferences per fish type
