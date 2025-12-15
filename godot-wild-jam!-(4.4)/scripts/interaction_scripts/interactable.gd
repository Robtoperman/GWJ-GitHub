extends Area2D

var is_in_area : bool = false  # Check if the player is in the area

func _on_body_entered(body: Node2D) -> void:
	is_in_area = true


func _on_body_exited(body: Node2D) -> void:
	is_in_area = false

func _process(delta: float) -> void:
	if is_in_area and Input.is_action_just_pressed("interact"):
		pass
