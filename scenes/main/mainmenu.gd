extends Node2D

@onready var background_music: AudioStreamPlayer = $BackgroundMusic
@onready var button_sound: AudioStreamPlayer = $ButtonSound

func _ready() -> void:
	SaveManager.load_game()

#var musicOnOrOff: bool = false
func _on_play_button_pressed() -> void:
	button_sound.play()
	get_tree().change_scene_to_file("res://scenes/episodes/episodes.tscn")


func _on_episodes_button_pressed() -> void:
	button_sound.play()
	get_tree().change_scene_to_file("res://scenes/episodes/episodes.tscn")


func _on_music_button_pressed() -> void:
	button_sound.play()
	if background_music.playing:
		background_music.stop()
	else:
		background_music.play()
