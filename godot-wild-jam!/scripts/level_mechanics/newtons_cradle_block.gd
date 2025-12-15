class_name NewtonsCradleBlock extends CharacterBody2D

@export var movement_speed : float = 500
@export var movement_direction : Vector2 = Vector2.ZERO
var last_movement_direction : Vector2 = Vector2.ZERO


func _physics_process(_delta: float) -> void:
	if movement_direction:
		velocity = movement_direction * movement_speed
	else:
		velocity = velocity.move_toward(Vector2.ZERO, movement_speed)
	
	move_and_slide()


func _on_body_entered(colliding_object: Node2D) -> void:
	var other_object = colliding_object.get_parent()
	if movement_direction:
		last_movement_direction = movement_direction
		print(name, "last movement direction change: ", last_movement_direction)
	# If the block hits another block
	if other_object is NewtonsCradleBlock:
		if other_object.last_movement_direction != last_movement_direction and not movement_direction:
			movement_direction = -other_object.last_movement_direction
			print(name, " collided ", last_movement_direction)
		else:
			movement_direction = Vector2.ZERO
			print(name, " stop: ", movement_direction)
	# If the block hits something that is not another block, bounce off of it
	else:
		movement_direction = -movement_direction
