extends CharacterBody2D

@onready var ray_cast_up: RayCast2D = $RayCastUp
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_down: RayCast2D = $RayCastDown

@export var movement_direction: Vector2 = Vector2.ZERO
@export var movement_speed : float = 500


func _process(_delta: float) -> void:
	if ray_cast_up.is_colliding():
		if movement_direction:  # If this block is moving, reverse it
			movement_direction = -movement_direction
		else:
			movement_direction = Vector2.DOWN
			
	if ray_cast_down.is_colliding():
		if movement_direction:  # If this block is moving, reverse it
			movement_direction = -movement_direction
		else: # If this block is not moving and is collided, set the movement to opposite of the ray cast
			movement_direction = Vector2.UP


# The function responsible for making the block move
func _physics_process(_delta: float) -> void:
	if movement_direction:
		velocity = movement_direction * movement_speed
	else:
		velocity = velocity.move_toward(Vector2.ZERO, movement_speed)
	
	move_and_slide()
