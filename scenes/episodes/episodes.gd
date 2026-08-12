extends Control

@onready var background_music: AudioStreamPlayer = $BackgroundMusic
@onready var button_sound: AudioStreamPlayer = $ButtonSound

@onready var episode_1_button: TextureButton = $UI/EpisodeArea/Episode1Button
@onready var episode_2_button: TextureButton = $UI/EpisodeArea/Episode2Button
@onready var episode_3_button: TextureButton = $UI/EpisodeArea/Episode3Button

var lock_texture = preload("res://assets/ui/4.png")
var one_star_texture = preload("res://assets/ui/3.png")
var two_star_texture = preload("res://assets/ui/2.png")
var three_star_texture = preload("res://assets/ui/1.png")

func _ready() -> void:
	update_episode_cards()

func update_episode_cards() -> void:
	print("Episode 1 stars: ", GameState.episode_stars[1])
	print("Episode 2 stars: ", GameState.episode_stars[2])
	print("Episode 3 stars: ", GameState.episode_stars[3])
	print("Unlocked episode: ", GameState.unlocked_episode)
	# Episode 1 is always unlocked
	episode_1_button.texture_normal = get_star_texture(
		GameState.episode_stars[1]
	)
	# Episode 2
	if GameState.unlocked_episode >= 2:
		episode_2_button.texture_normal = get_star_texture(
			GameState.episode_stars[2]
		)
	else:
		episode_2_button.texture_normal = lock_texture
	# Episode 3
	if GameState.unlocked_episode >= 3:
		episode_3_button.texture_normal = get_star_texture(
			GameState.episode_stars[3]
		)
	else:
		episode_3_button.texture_normal = lock_texture

func get_star_texture(stars: int) -> Texture2D:
	match stars:
		1:
			return one_star_texture
		2:
			return two_star_texture
		3:
			return three_star_texture
		_:
			return one_star_texture


func _on_episode_1_button_pressed() -> void:
	button_sound.play()
	GameState.selected_episode = 1
	get_tree().change_scene_to_file("res://scenes/play.tscn")


func _on_episode_2_button_pressed() -> void:
	button_sound.play()
	if GameState.unlocked_episode < 2:
		return
	GameState.selected_episode = 2
	get_tree().change_scene_to_file("res://scenes/play.tscn")


func _on_episode_3_button_pressed() -> void:
	button_sound.play()
	if GameState.unlocked_episode < 3:
		return
	GameState.selected_episode = 3
	get_tree().change_scene_to_file("res://scenes/play.tscn")

#func _on_episode_4_button_pressed() -> void:
	#button_sound.play()
	#if GameState.unlocked_episode < 3:
		#return
	#GameState.selected_episode = 3
	#get_tree().change_scene_to_file("res://scenes/play.tscn")


func _on_back_button_pressed() -> void:
	button_sound.play()
	get_tree().change_scene_to_file("res://scenes/main/main.tscn")


func _on_music_button_pressed() -> void:
	button_sound.play()
	if background_music.playing:
		background_music.stop()
	else:
		background_music.play()
