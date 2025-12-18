class_name NewtonsCradleBlock extends CharacterBody2D

@export var movement_speed : float = 500
@export var movement_direction : Vector2 = Vector2.ZERO
var other_block_direction : Vector2 = Vector2.ZERO
var colliding_on_start_check : bool = true
var block_group : Array = Array()


func _ready() -> void:
	# Sets colliding_on_start_check to false after all block scripts have executed once
	set_deferred("colliding_on_start_check", false)


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
	
	if other_block is NewtonsCradleBlock and colliding_on_start_check == true:
		block_group.append(other_block)
	
	
	# Change this blocks information accordingly
	# Set_deferred() sets the first value to the given property at the end of the frame, by passing the script execution order
	if block_group:
		pass
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
	
	# print(name, ": ", block_group)
