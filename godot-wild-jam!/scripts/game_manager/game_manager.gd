extends Node


@export var pause_menu : Control
var game_paused : bool = false


func pause_game():
	Engine.time_scale = 0

func unpause_game():
	Engine.time_scale = 1

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause_unpause") and not game_paused:
		game_paused = true
		pause_menu.show()
		pause_game()
	elif Input.is_action_just_pressed("pause_unpause") and game_paused:
		game_paused = false
		pause_menu.hide()
		unpause_game()
