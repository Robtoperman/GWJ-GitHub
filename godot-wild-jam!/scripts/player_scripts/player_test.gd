extends RigidBody2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var ray_cast_2d: RayCast2D = $RayCast2D

@export var move_speed : int  = 50
@export var max_speed : int = 2000
@export var jump_force : int = -700
#var can_move : bool = false

func _physics_process(delta: float) -> void:
	var direction = Input.get_axis("move_left", "move_right")
	var force = Vector2.ZERO
	
	if direction:
		force.x = move_speed * direction
		if abs(linear_velocity.x) > max_speed:  # Caps speed
			linear_velocity.x = max_speed * direction
	
	if _on_floor() and Input.is_action_just_pressed("jump"):
		force.y = jump_force
	
	apply_central_impulse(force)  # Applies a directional impulse without affecting rotation

func _integrate_forces(state) -> void:
	rotation_degrees = 0

func _on_floor():
	if ray_cast_2d.is_colliding():
		return true
