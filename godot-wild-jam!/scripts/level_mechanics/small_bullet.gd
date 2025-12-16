extends CharacterBody2D

var direction : Vector2 = Vector2(0, 1)
var speed : float = 0.0
var life_time : float = 0.0


func _physics_process(delta: float) -> void:
	global_position += direction.rotated(get_parent().rotation) * speed * delta

	move_and_slide()
