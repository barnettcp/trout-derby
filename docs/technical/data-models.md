# Data Models

## Fish
```
Fish {
  id: int
  species: string
  length: float          # inches, normally distributed
  weight: float          # pounds, normally distributed
  is_trophy: bool
  trophy_name: string    # null for standard fish
  trophy_title: string   # title granted to the player who catches this fish; null for standard fish
  position: Vector2
  orientation: float     # degrees
  tick_interval: float   # seconds between movement ticks
  state: enum            # idle, moving, biting, hooked, caught
  bite_radius: float
  rounds_since_last_caught: int  # 0 if caught this round, increments each round; persisted across rounds
}
```

## Player
```
Player {
  id: int
  name: string
  title: string           # earned by catching a trophy fish; most recent or player-selected
  position: Vector2
  state: enum            # idle, casting, waiting, hooking, reeling
  fish_caught: Array[Fish]
  score: int
  awards: Array[Award]   # persisted across rounds
}
```

## Round / Derby
```
Round {
  id: int
  duration: float        # seconds
  time_remaining: float
  fish_pool: Array[Fish]
  players: Array[Player]
  state: enum            # waiting, active, ended
}
```

## Award
```
Award {
  type: string           # "most_fish", "biggest_catch", "trophy_catch", etc.
  round_id: int
  player_id: int
  timestamp: datetime
}
```

## Leaderboard Entry
```
LeaderboardEntry {
  player_id: int
  player_name: string
  total_fish: int
  total_awards: int
  best_round_score: int
  trophy_fish_caught: int
}
```

## Persistence Format
- Prototype: local file or Godot `ConfigFile`
- Final game: browser localStorage (JSON blob)
- Schema versioning approach for future changes
