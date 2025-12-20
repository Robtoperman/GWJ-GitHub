class_name NewtonsCradleBlock extends CharacterBody2D

@onready var area: Area2D = $Area2D

@export var movement_speed : float = 500
@export var movement_direction : Vector2 = Vector2.ZERO
@export var top_block : Node2D
@export var bottom_block : Node2D
var other_block_direction : Vector2 = Vector2.ZERO
var set_group_done : bool = false


func _ready() -> void:
	# Sets colliding_on_start_check to false after all block scripts have executed once
	set_deferred("set_group_done", true)
	
	area.monitoring = false
	area.set_deferred("monitoring", true)


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
		other_block_direction = other_block.movement_direction
	
	
	# Set_deferred() sets the first value to the given property at the end of the frame, after all block scripts have ran, by passing the script execution order
	# Other block is a NewtonsCradle
	if other_block is NewtonsCradleBlock:
		# This block is not moving
		if !movement_direction:
			# Will transfer the movement to the top block in the group
			if top_block:
				top_block.set_deferred("movement_direction", other_block_direction)
			# Will transfer the movement to the bottom block in the group
			elif bottom_block:
				bottom_block.set_deferred("movement_direction", other_block_direction)
			# Is his by a block that is moving, will transfer the movement to itself
			else:
				set_deferred("movement_direction", other_block_direction)
		# This block is moving and hits a block that is not, stops
		elif movement_direction and not other_block_direction:
			set_deferred("movement_direction", Vector2.ZERO)
		# This block is moving and his a block that is moving, transfers movement to itself
		else:
			set_deferred("movement_direction", other_block_direction)
	# Other block is a wall
	else:
		movement_direction = -movement_direction



func disregard(other_block):
		# Change this blocks information accordingly
	# Set_deferred() sets the first value to the given property at the end of the frame, by passing the script execution order
	if top_block:
		# If the block is not moving, is in a group of blocks, and is collided with a block that is moving, move the
		if other_block is NewtonsCradleBlock and !movement_direction:
			top_block.set_deferred("movement_direction", other_block_direction)
	elif bottom_block:
		if other_block is NewtonsCradleBlock and !movement_direction:
			bottom_block.set_deferred("movement_direction", other_block_direction)
	else:
		if other_block is NewtonsCradleBlock:
			# If this block is not moving and collides with another block, then move this one the same as that blocks movement
			if !movement_direction:
				set_deferred("movement_direction", other_block_direction)
				# print(name, " Transfer")
			# If this block is moving and collides with a block that is not, then set this block's movement to 0
			elif movement_direction and not other_block_direction:
				set_deferred("movement_direction", Vector2.ZERO)
				# print(name, " Stop")
			# If the block is moving and hits another block that is moving
			else: 
				set_deferred("movement_direction", other_block_direction)
				# print(name, " Switch")
		# If the block hits a wall
		else:
			movement_direction = -movement_direction
			# print(name, "Ricochet")
