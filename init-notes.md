# Trout Derby
Super simple, almost dumb. The idea is a super laid back fishing game where players begin casting into a pond that is full of fish. There are a set number of fish in the pond and when one is caught, it is gone until the next derby begins. At the end of the derby, the players' fish count is tallied and awards are given out. Award counts should persist for players, but we would require no account creation for this.


## Initial Notes
Small hand-made polygon with mayyybe 8 points for the pond. Green grass outside and blue for the water.

Square block people with a simple fishing rod. Line is thin white, bobber is red and white.

Fishing rod casts some distance (min/max timing thing). Ideally a player can cast either into the middle of the pond or close enough so that a fish in the middle could still possibly bite.

Start with bobber and random chance based on location of cast. Consider adding lure options later. Keep it simple.

Fish will not be visible to the player, the player will need to learn where fish like to be in this pond. Control the location of fish spawning through a noise map and/or hand-created by me.

People can move, cast just has to hit in the water. People can't walk into the water.

FIXED number of fish per round. Each fish is an actual game object that moves around. Need to consider how these fish can move around in a realistic way, with a radius where they may be interested in biting.
> Idea for fish movement: Fish movement works in "ticks" where the fish moves in a random direction, possibly constrained (e.g. between 0 and 140 degrees) from its current orientation. Then, the fish darts forward to its new location. Some mechanism must help fish not crowd into specific areas over the course of the game. Variables to control tempo of movement. Not all fish need to move at the same time, each should be unique.

One to two trophy fish that are unique to each round, initiates some sort of a title for the player. Not all trophy fish are present per round. Goal is 3-5 for initial prototype. Minimal back-story but different icon.

Score is number of fish caught when the timer "derby" ends.

Timer resets at 2 or 5 minutes (variable) for initial prototype

Long-term goal is to have maybe a 15-minute round in a lake that is multiplayer, people log in to catch as many fish as they can and get on a leaderboard with maybe long-term stats/rewards. The game is always running so players can jump in and catch fish in a a chill fashion at any hour of the day. Play should feel arcade-y, fish placement should be thoughtful, with density based on weather and temperature.

Short-term goal is two stages of a minimum viable product:
1. Playable as a single player, can cast and can catch as many fish as possible before the derby ends
    - Minimal but nice UI/UX
    - Minimal sound
    - Simple animation
2. Same simple style, can play as multiplayer on itch.io or similar, possibly mobile
    - Stats System

The goal is minimal assets, simple and non-invasive multiplayer, and solid colors. The game would be 2D and top-down for simplicity.

From a learning perspective, this would be a much simpler game to create than other ideas. Build entirely in Godot using GDSCript. This would give practice on some game mechanics that could be used in other projects, as well as serve as a nice platform to learn how to create a small multiplayer game work well.