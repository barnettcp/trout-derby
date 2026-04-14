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
- 3 to 5 trophy fish defined for initial prototype
- Not all trophy fish appear in every round (random selection per derby)
- One to two trophy fish per round maximum
- Each trophy fish has:
  - Unique name
  - Minimal backstory (one or two sentences)
  - Distinct icon (different from standard fish)
  - Exceptional length/weight values
- Catching a trophy fish grants the player a title

## Trophy Fish Roster
<!-- Define each trophy fish here -->

| Name | Description | Length | Weight | Notes | Title Gained |
|------|-------------|--------|--------|-------| -------------|
| TBD  | TBD         | TBD    | TBD    | TBD   | TBD          |

## Future Considerations
- Additional species beyond trout
- Seasonal or weather-based fish variation
- Lure preferences per fish type
