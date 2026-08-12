extends Node

const SAVE_PATH := "user://save.json"

func save_game() -> void:
	var data := {
		"unlocked_episode": GameState.unlocked_episode,
		"episode_stars": GameState.episode_stars
	}

	var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)

	if file:
		file.store_string(JSON.stringify(data))
		file.close()

		print("Game saved!")
	else:
		print("Failed to open save file.")


func load_game() -> void:
	if not FileAccess.file_exists(SAVE_PATH):
		print("No save file found. Starting new game.")
		return

	var file := FileAccess.open(SAVE_PATH, FileAccess.READ)

	if file:
		var json_text := file.get_as_text()
		file.close()

		var data = JSON.parse_string(json_text)

		if data == null:
			print("Save file is invalid.")
			return

		GameState.unlocked_episode = int(
			data.get("unlocked_episode", 1)
		)

		var saved_stars = data.get("episode_stars", {})

		for episode in GameState.episode_stars.keys():
			var key := str(episode)

			if saved_stars.has(key):
				GameState.episode_stars[episode] = int(
					saved_stars[key]
				)

		print("Game loaded!")
