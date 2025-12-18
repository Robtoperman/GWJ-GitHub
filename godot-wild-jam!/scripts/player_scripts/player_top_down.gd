extends RigidBody2D

@export var movement_speed : float = 100.0
@export var max_speed : float = 1000.0
@export var drag_factor : float = 50.0
var character_direction : Vector2


func _physics_process(_delta: float) -> void:
	character_direction.x = Input.get_axis("move_left", "move_right")
	character_direction.y = Input.get_axis("move_up", "move_down")
	character_direction = character_direction.normalized()
	var force = Vector2.ZERO
	
	if character_direction:
		force = character_direction * movement_speed
		#if abs(linear_velocity.x) > max_speed:  # Caps speed
		#	linear_velocity = max_speed * character_direction
	
	#if abs(force):
	#	force.x -= drag_factor
	#	force.y -= drag_factor
	
	print(linear_velocity)
	
	apply_central_impulse(force)  # Applies a directional impulse without affecting rotation
