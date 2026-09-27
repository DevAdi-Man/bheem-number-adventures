extends Control

@onready var background: TextureRect = $Background
@onready var sub_question: TextureRect = $UI/SubQuestion
@onready var sub_question_label: Label = $UI/SubQuestion/subQuestionsLabel
@onready var question: TextureRect = $UI/Question
@onready var question_label: Label = $UI/Question/questionsLabel
@onready var answer_button_1: TextureButton = $UI/AnswerQuestion/AnswerButton1
@onready var answer_button_2: TextureButton = $UI/AnswerQuestion/AnswerButton2
@onready var answer_button_3: TextureButton = $UI/AnswerQuestion/AnswerButton3
@onready var answer_button_label_1: Label = $UI/AnswerQuestion/AnswerButton1/AnswerLabel1
@onready var answer_button_label_2: Label = $UI/AnswerQuestion/AnswerButton2/AnswerLabel2
@onready var answer_button_label_3: Label = $UI/AnswerQuestion/AnswerButton3/AnswerLabel3
@onready var butterfly: AnimatedSprite2D = $UI/Butterfly
@onready var butterfly2: AnimatedSprite2D = $UI/Butterfly2
@onready var butterfly3: AnimatedSprite2D = $UI/Butterfly3


@onready var answer_question: GridContainer = $UI/AnswerQuestion
@onready var character: TextureRect = $UI/character


#sound
@onready var question_sound: AudioStreamPlayer = $QuestionSound
@onready var sub_question_sound: AudioStreamPlayer = $SubQuestionSound
@onready var right_answer_sound: AudioStreamPlayer = $RightAnswerSound
@onready var wrong_answer_sound: AudioStreamPlayer = $WrongAnswerSound
@onready var button_press_sound: AudioStreamPlayer = $ButtonPressSound
@onready var laddoo_plates: TextureRect = $UI/laddoPlate


@onready var next_button: TextureButton = $UI/NextButton


var nose_bheem_character = preload('res://assets/nose_character__bheem.png')
var laddoo_bheem_character = preload("res://assets/laddoo_bheem_character.png")

var background_inside = preload("res://assets/background/backgroundInside.png")
var background_episode = preload("res://assets/background/EpisodeBackground.png")
var background_outside = preload("res://assets/background/backgroundOutside.png")
var background_butterfly = preload("res://assets/background/backgroundButterfly.png")

var episode_one_question_sound = preload("res://assets/sound/let_counts.mp3")
var episode_one_sub_question_sound = preload("res://assets/sound/001.mp3")
var episode_three_sub_question_sound = preload("res://assets/sound/09.mp3")

var nose_01 = preload("res://assets/ui/nose_01.png")
var nose_02 = preload("res://assets/ui/nose_04.png")
var nose_04 = preload("res://assets/ui/nose_08.png")

var nose_pressed_01 = preload("res://assets/ui/nose_02.png")
var nose_pressed_02 = preload("res://assets/ui/nose_06.png")
var nose_pressed_04 = preload("res://assets/ui/nose_10.png")

var grid_01 = preload("res://assets/ui/gridColorButtons_01.png")
var grid_02 = preload("res://assets/ui/gridColorButtons_02.png")
var grid_03 = preload("res://assets/ui/gridColorButtons_03.png")


var episode_two_sub_question_sound = preload("res://assets/sound/03.mp3")

var answers_enabled := false
var correct_answer := 1
var wrong_attempts := 0


func _ready():
	next_button.visible = false
	print("Selected Episode: ", GameState.selected_episode)
	load_episode()
	setup_answer_buttons()
	await get_tree().process_frame
	play_intro_animation()

# singal for back button
func _on_back_button_pressed() -> void:
	button_press_sound.play()
	get_tree().change_scene_to_file("res://scenes/episodes/episodes.tscn")

# load episodes like 1,2
func load_episode()-> void:
	wrong_attempts = 0
	match GameState.selected_episode:
		1:
			load_episode_one()
		2:
			load_episode_two()
		3:
			load_episode_three()

# answer buttons start here
func _on_answer_button_1_pressed() -> void:
	button_press_sound.play()
	select_answer(answer_button_1)
	check_answer(1)
	print("Answer 1 selected")
func _on_answer_button_2_pressed() -> void:
	button_press_sound.play()
	select_answer(answer_button_2)
	check_answer(2)
	print("Answer 2 selected")
func _on_answer_button_3_pressed() -> void:
	button_press_sound.play()
	select_answer(answer_button_3)
	check_answer(3)
	print("Answer 3 selected")
# answer button end here

#episode 1 and their changes according to screens
func load_episode_one()-> void:
	laddoo_plates.visible = false
	character.texture = nose_bheem_character
	background.texture = background_episode
	print("question1")
	question_label.text = "LET'S COUNTS!"
	sub_question_label.text = "How many nose Bheem have?"
	
	question_sound.stream = episode_one_question_sound
	sub_question_sound.stream = episode_one_sub_question_sound
	
	correct_answer = 2
#episode 1 and their changes according to screens
func load_episode_two()-> void:
	print("question2")
	background.texture = background_inside
	laddoo_plates.visible = true
	character.texture = laddoo_bheem_character
	character.position = Vector2(270,110)
	answer_question.position = Vector2(230, 250)
	question_label.text = "LET'S COUNTS!"
	sub_question_label.text = "How many laddoos are there on the plates?"
	sub_question_label.add_theme_font_size_override("font_size", 24)
	
	question_sound.stream = episode_one_question_sound
	sub_question_sound.stream = episode_two_sub_question_sound
	correct_answer = 2
	answer_button_label_1.visible = true
	answer_button_label_2.visible = true
	answer_button_label_3.visible = true
	answer_button_label_1.text = "0"
	answer_button_label_2.text = "1"
	answer_button_label_3.text = "4"

#episode 2
func load_episode_three()-> void:
	print("question3")
	background.texture = background_butterfly
	laddoo_plates.visible = false
	butterfly.visible = true
	butterfly2.visible = true
	butterfly3.visible = true
	butterfly.position = Vector2(460,400)
	butterfly2.position = Vector2(800,420)
	butterfly3.position = Vector2(540,480)
	question_label.text = "LET'S COUNT!"
	sub_question_label.text = "How many butterflies flutring new flower"
	character.texture = laddoo_bheem_character
	character.position = Vector2(30,200)
	answer_question.position = Vector2(0, 500)
	question_sound.stream = episode_one_question_sound
	sub_question_sound.stream = episode_three_sub_question_sound
	correct_answer = 3
	answer_button_label_1.visible = true
	answer_button_label_2.visible = true
	answer_button_label_3.visible = true
	answer_button_label_1.text = "4"
	answer_button_label_2.text = "5"
	answer_button_label_3.text = "3"

func play_intro_animation() -> void:
	next_button.visible = false
	answers_enabled = false

	# Disable buttons while animation is playing
	answer_button_1.disabled = true
	answer_button_2.disabled = true
	answer_button_3.disabled = true

	# Save original positions
	var question_pos := question.position
	var sub_question_pos := sub_question.position

	var answer1_pos := answer_button_1.position
	var answer2_pos := answer_button_2.position
	var answer3_pos := answer_button_3.position

	# Start question banner above the screen
	question.position.y = question_pos.y - 250
	question.modulate.a = 0.0

	# Start sub-question above the screen
	sub_question.position.y = sub_question_pos.y - 150
	sub_question.modulate.a = 0.0

	# Start answers below their final positions
	answer_button_1.position.y = answer1_pos.y + 250
	answer_button_2.position.y = answer2_pos.y + 250
	answer_button_3.position.y = answer3_pos.y + 250

	answer_button_1.modulate.a = 0.0
	answer_button_2.modulate.a = 0.0
	answer_button_3.modulate.a = 0.0
	
	# Question banner
	var tween := create_tween()
	tween.set_parallel(true)

	tween.tween_property(
		question,
		"position",
		question_pos,
		1.0
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

	tween.tween_property(
		question,
		"modulate:a",
		1.0,
		0.8
	)

	await tween.finished
	question_sound.play()
	
	await question_sound.finished
	# Sub-question
	var sub_tween := create_tween()
	sub_tween.set_parallel(true)

	sub_tween.tween_property(
		sub_question,
		"position",
		sub_question_pos,
		0.8
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	
	sub_tween.tween_property(
		sub_question,
		"modulate:a",
		1.0,
		0.6
	)
	
	await sub_tween.finished
	sub_question_sound.play()
	
	await sub_question_sound.finished
	# Answer 1
	await animate_answer(answer_button_1, answer1_pos)

	# Answer 2
	await animate_answer(answer_button_2, answer2_pos)

	# Answer 3
	await animate_answer(answer_button_3, answer3_pos)

	# Now allow player to answer
	answers_enabled = true

	answer_button_1.disabled = false
	answer_button_2.disabled = false
	answer_button_3.disabled = false

func animate_answer(
	button: TextureButton,
	final_position: Vector2
) -> void:
	var tween := create_tween()
	tween.set_parallel(true)

	tween.tween_property(
		button,
		"position",
		final_position,
		0.7
	).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)

	tween.tween_property(
		button,
		"modulate:a",
		1.0,
		0.5
	)

	await tween.finished

	await get_tree().create_timer(0.08).timeout

# which button is seleted for answer
func select_answer(button: TextureButton) -> void:
	# Reset all buttons to normal size
	animate_button_release(answer_button_1)
	animate_button_release(answer_button_2)
	animate_button_release(answer_button_3)

	# Episode 1 uses toggle/pressed state
	if GameState.selected_episode == 1:
		answer_button_1.button_pressed = false
		answer_button_2.button_pressed = false
		answer_button_3.button_pressed = false
		button.button_pressed = true

	# Scale the selected button down
	animated_button_press(button)

# check answer with right answer
func check_answer(answer: int) -> void:
	if not answers_enabled:
		return
	if answer == correct_answer:
		answers_enabled = false
		var stars := calculate_stars()
		
		print("Correct answer!")
		print("Stars earned: ", stars)
		GameState.complete_episode(GameState.selected_episode,stars)
		SaveManager.save_game()
		right_answer_sound.play()
		await right_answer_sound.finished
		
		if GameState.selected_episode >= 3:
			_play_exit_animation(false)
		else:
			next_button.visible = true
	else:
		wrong_attempts += 1
		print("Wrong answer!")
		print("Wrong attempts: ", wrong_attempts)
		wrong_answer_sound.play()
		answers_enabled = true

func calculate_stars() -> int:
	if wrong_attempts == 0:
		return 3
	elif wrong_attempts == 1:
		return 2
	else:
		return 1

func setup_answer_buttons() -> void:
	if GameState.selected_episode == 1:
		# Episode 1 - nose buttons
		answer_button_1.texture_normal = nose_01
		answer_button_2.texture_normal = nose_02
		answer_button_3.texture_normal = nose_04
		
		# Use pressed textures for nose buttons
		answer_button_1.texture_pressed = nose_pressed_01
		answer_button_2.texture_pressed = nose_pressed_02
		answer_button_3.texture_pressed = nose_pressed_04
		
		# Enable toggle behavior
		answer_button_1.toggle_mode = true
		answer_button_2.toggle_mode = true
		answer_button_3.toggle_mode = true

	elif GameState.selected_episode == 2 or GameState.selected_episode == 3:
		# Episode 2 - colored grid buttons
		answer_button_1.texture_normal = grid_01
		answer_button_2.texture_normal = grid_02
		answer_button_3.texture_normal = grid_03
		
		# No pressed state
		answer_button_1.texture_pressed = null
		answer_button_2.texture_pressed = null
		answer_button_3.texture_pressed = null
		
		# Don't use toggle mode
		answer_button_1.toggle_mode = false
		answer_button_2.toggle_mode = false
		answer_button_3.toggle_mode = false

func animated_button_press(button: TextureButton)-> void:
	var tween:= create_tween()
	tween.tween_property(
		button,
		"scale",
		Vector2(0.94,0.94),
		0.08
	).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)

func animate_button_release(button: TextureButton) -> void:
	var tween := create_tween()
	tween.tween_property(
		button,
		"scale",
		Vector2(1.0, 1.0),
		0.12
	).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)


func _on_next_button_pressed() -> void:
	_play_exit_animation(true)

func _play_exit_animation(from_next_button: bool = false) -> void:
	if from_next_button:
		button_press_sound.play()
		next_button.visible = false
	
	var q_pos := question.position
	var sq_pos := sub_question.position
	var a1_pos := answer_button_1.position
	var a2_pos := answer_button_2.position
	var a3_pos := answer_button_3.position
	var char_pos := character.position
	var l_pos := laddoo_plates.position
	var b1_pos := butterfly.position
	var b2_pos := butterfly2.position
	var b3_pos := butterfly3.position
	
	var tween_out = create_tween()
	tween_out.set_parallel(true)
	
	tween_out.tween_property(question, "modulate:a", 0.0, 0.6).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween_out.tween_property(question, "position:y", q_pos.y - 250, 0.6).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	
	tween_out.tween_property(sub_question, "modulate:a", 0.0, 0.6).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween_out.tween_property(sub_question, "position:y", sq_pos.y - 150, 0.6).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	
	tween_out.tween_property(answer_button_1, "modulate:a", 0.0, 0.6).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween_out.tween_property(answer_button_1, "position:y", a1_pos.y + 250, 0.6).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	
	tween_out.tween_property(answer_button_2, "modulate:a", 0.0, 0.6).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween_out.tween_property(answer_button_2, "position:y", a2_pos.y + 250, 0.6).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	
	tween_out.tween_property(answer_button_3, "modulate:a", 0.0, 0.6).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween_out.tween_property(answer_button_3, "position:y", a3_pos.y + 250, 0.6).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	
	tween_out.tween_property(character, "modulate:a", 0.0, 0.6).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween_out.tween_property(character, "position:x", char_pos.x - 200, 0.6).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	
	if butterfly.visible:
		tween_out.tween_property(butterfly, "modulate:a", 0.0, 0.6).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
		tween_out.tween_property(butterfly, "position:y", b1_pos.y - 200, 0.6).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
		tween_out.tween_property(butterfly2, "modulate:a", 0.0, 0.6).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
		tween_out.tween_property(butterfly2, "position:y", b2_pos.y - 200, 0.6).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
		tween_out.tween_property(butterfly3, "modulate:a", 0.0, 0.6).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
		tween_out.tween_property(butterfly3, "position:y", b3_pos.y - 200, 0.6).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
		
	if laddoo_plates.visible:
		tween_out.tween_property(laddoo_plates, "modulate:a", 0.0, 0.6).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
		tween_out.tween_property(laddoo_plates, "position:y", l_pos.y + 200, 0.6).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	
	await tween_out.finished
	
	# Restore original positions
	question.position = q_pos
	sub_question.position = sq_pos
	answer_button_1.position = a1_pos
	answer_button_2.position = a2_pos
	answer_button_3.position = a3_pos
	character.position = char_pos
	laddoo_plates.position = l_pos
	butterfly.position = b1_pos
	butterfly2.position = b2_pos
	butterfly3.position = b3_pos
	
	butterfly.visible = false
	butterfly2.visible = false
	butterfly3.visible = false
	butterfly.modulate.a = 1.0
	butterfly2.modulate.a = 1.0
	butterfly3.modulate.a = 1.0
	character.modulate.a = 1.0
	laddoo_plates.modulate.a = 1.0
	
	GameState.selected_episode += 1
	if GameState.selected_episode > 3:
		var pannel_scene = preload("res://scenes/pannel.tscn")
		var pannel_inst = pannel_scene.instantiate()
		add_child(pannel_inst)
	else:
		load_episode()
		setup_answer_buttons()
		play_intro_animation()
