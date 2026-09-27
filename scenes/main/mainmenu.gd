extends Node2D

@onready var button_sound: AudioStreamPlayer = $ButtonSound
@onready var music_button: TextureButton = $UI/RootUI/MusicButton

func _ready() -> void:
	SaveManager.load_game()
	MusicManager.sync_sound_button(music_button)
	

#var musicOnOrOff: bool = false
func _on_play_button_pressed() -> void:
	button_sound.play()
	get_tree().change_scene_to_file("res://scenes/episodes/episodes.tscn")


func _on_episodes_button_pressed() -> void:
	button_sound.play()
	get_tree().change_scene_to_file("res://scenes/episodes/episodes.tscn")


func _on_music_button_pressed() -> void:
	button_sound.play()
	MusicManager.toggle_music()
	MusicManager.sync_sound_button(music_button)
