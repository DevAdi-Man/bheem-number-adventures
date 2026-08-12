extends Node

var selected_episode: int = 1
var unlocked_episode := 1

var episode_stars := {
	1: 0,
	2: 0,
	3: 0
}
func complete_episode(episode: int, stars: int) -> void:
	episode_stars[episode] = stars

	if episode < 3:
		unlocked_episode = max(unlocked_episode, episode + 1)
