extends Control


func _on_episode_1_button_pressed() -> void:
	GameState.selected_episode = 1
	get_tree().change_scene_to_file("res://scenes/play.tscn")


func _on_episode_2_button_pressed() -> void:
	GameState.selected_episode = 2
	get_tree().change_scene_to_file("res://scenes/play.tscn")


func _on_episode_3_button_pressed() -> void:
	GameState.selected_episode = 3
	get_tree().change_scene_to_file("res://scenes/play.tscn")


func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main/main.tscn")
