class_name NewtonsCradleBlock extends CharacterBody2D

@export var movement_speed : float = 500
@export var movement_direction : Vector2 = Vector2.ZERO
var other_block_direction : Vector2 = Vector2.ZERO
var last_movement_direction : Vector2 = movement_direction
var block_ready : bool = false


func _physics_process(_delta: float) -> void:
	if movement_direction:
		velocity = movement_direction * movement_speed
	else:
		velocity = velocity.move_toward(Vector2.ZERO, movement_speed)
	
	move_and_slide()


func _on_body_entered(colliding_object: Node2D) -> void:
	# The colliding object is the Area2D, so I do this to make the parent easier to access
	var other_block = colliding_object.get_parent()
	
	
	# Get information from the other block
	if other_block is NewtonsCradleBlock:
		last_movement_direction = movement_direction
		other_block_direction = other_block.movement_direction
	
	
	
	# Change this blocks information accordingly
	if other_block is NewtonsCradleBlock:
		# If this block is not moving and collides with another block, then move this one the same as that blocks movement
		if !movement_direction:
			last_movement_direction = movement_direction
			movement_direction = other_block_direction
			print(name, " Transfer")
		# If this block is moving and collides with a block that is not, then set this blocks movement to 0
		elif movement_direction and not other_block_direction:
			last_movement_direction = movement_direction
			movement_direction = Vector2.ZERO
			print(name, " Stop")
		# If the block is moving and hits another block that is moving
		else: 
			movement_direction = other_block_direction
			print(name, " Switch")
	# If the block hits a wall
	else:
		movement_direction = -movement_direction
	
	
	
	
	# Set the last_movement_direction variable if the direction changes
	#if movement_direction:
	#	last_movement_direction = movement_direction
	#	print(name, ": Last movement direction change: ", last_movement_direction)
	#
	# If the block hits another block
	#if other_object is NewtonsCradleBlock:
	#	# If this block is not moving, set the movement to that of the other block
	#	if !movement_direction:
	#		movement_direction = other_object.last_movement_direction
	#		print(name, " collided ", movement_direction)
	#	
	#	# If this block is moving and the other block is not moving, set this blocks movement to 0
	#	elif movement_direction and other_object.last_movement_direction != last_movement_direction:
	#		movement_direction = Vector2.ZERO
	#		print(name, " stop: ", movement_direction)
	#
	# If the block hits something that is not another block, bounce off of it
	#else:
	#	movement_direction = -movement_direction
