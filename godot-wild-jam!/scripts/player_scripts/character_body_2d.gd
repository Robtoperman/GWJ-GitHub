class_name Player extends CharacterBody2D

@export var movement_speed : float = 1000
@onready var gun_rotation : Node2D = $GunRotation
@onready var small_bullet : PackedScene = preload("res://scenes/level_mechanics/small_bullet.tscn")

var character_direction : Vector2 = Vector2.ZERO


func die():
	queue_free()


func _unhandled_input(_event: InputEvent) -> void:
	character_direction.x = Input.get_axis("move_left", "move_right")
	character_direction.y = Input.get_axis("move_up", "move_down")
	character_direction = character_direction.normalized()

func _physics_process(_delta: float) -> void:
	if character_direction:
		velocity = character_direction * movement_speed
	else:
		velocity = velocity.move_toward(Vector2.ZERO, movement_speed)
		
	gun_rotation.look_at(get_global_mouse_position())
	
	if Input.is_action_just_pressed("fire"):
		var bullet = small_bullet.instantiate()
		bullet.speed = 300.0
		# gun_rotation.add_child(bullet)
	
	move_and_slide()
