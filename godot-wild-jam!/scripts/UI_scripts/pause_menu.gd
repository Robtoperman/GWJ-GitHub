extends Control

@export var game_manager : Node

func _ready() -> void:
	hide()


func _on_resume() -> void:
	game_manager.game_paused = false
	game_manager.unpause_game()
	hide()
