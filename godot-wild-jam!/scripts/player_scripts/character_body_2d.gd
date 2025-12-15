extends CharacterBody2D

@export var movement_speed : float = 1000

var character_direction : Vector2 = Vector2.ZERO


func _unhandled_input(_event: InputEvent) -> void:
	character_direction.x = Input.get_axis("move_left", "move_right")
	character_direction.y = Input.get_axis("move_up", "move_down")
	character_direction = character_direction.normalized()

func _physics_process(_delta: float) -> void:
	if character_direction:
		velocity = character_direction * movement_speed
	else:
		velocity = velocity.move_toward(Vector2.ZERO, movement_speed)
	
	move_and_slide()
