extends Area2D

@export var dialogue_script : Resource
@onready var icon: Sprite2D = $icon

var is_in_area : bool = false  # Check if the player is in the area


func _ready() -> void:
	icon.hide()

func _on_body_entered(body: Node2D) -> void:
	icon.show()
	is_in_area = true

func _on_body_exited(body: Node2D) -> void:
	icon.hide()
	is_in_area = false

func _process(delta: float) -> void:
	if is_in_area and Input.is_action_just_pressed("interact"):
		if dialogue_script:
			DialogueManager.show_dialogue_balloon(dialogue_script)
