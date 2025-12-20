class_name Player extends CharacterBody2D

@export var movement_speed : float = 1000
@onready var gun_rotation_pivot: Node2D = $GunRotationPivot
@onready var gun_spawn_point: Node2D = $GunRotationPivot/GunSpawnPoint
@onready var slime_ball : PackedScene = preload("res://scenes/level_mechanics/slime_ball.tscn")
@onready var player_jump_time: Timer = $PlayerJumpTimeUp
@onready var player_sprite: Sprite2D = $PlayerSprite
@onready var player_fall_time: Timer = $PlayerJumpTimeDown
@onready var area_cradles: Area2D = $AreaCradles
@onready var area_pit: Area2D = $AreaPit

var character_direction : Vector2 = Vector2.ZERO
var is_on_ice : bool = false
var is_above_pit : bool = false
var is_jumping : bool = false
var is_on_ground : bool = true
var is_on_cadle_block : bool = false


func die():
	queue_free()

func fall():
	movement_speed = 0
	player_sprite.scale = Vector2(0.5, 0.5)


func _unhandled_input(_event: InputEvent) -> void:
	character_direction.x = Input.get_axis("move_left", "move_right")
	character_direction.y = Input.get_axis("move_up", "move_down")
	character_direction = character_direction.normalized()
	
	if Input.is_action_just_pressed("fire"):
		var bullet = slime_ball.instantiate()
		bullet.speed = 1000.0
		bullet.position = gun_spawn_point.global_position
		bullet.rotation = gun_rotation_pivot.global_rotation
		bullet.aim_rotation = gun_rotation_pivot.global_rotation
		get_tree().current_scene.add_child(bullet)
	
	if Input.is_action_just_pressed("jump") and is_on_ground:
		is_jumping = true
		is_on_ground = false
		area_cradles.monitoring = false
		area_pit.monitoring = false
		if get_parent() is NewtonsCradleBlock:
			velocity += get_parent().velocity
		player_jump_time.start()

func _physics_process(_delta: float) -> void:
	if is_on_ice:
		if character_direction:
			velocity = velocity.lerp((character_direction * movement_speed), 0.03)
		else:
			velocity = velocity.lerp(Vector2.ZERO, 0.03)
	elif !is_on_ground:
		if character_direction:
			velocity = velocity.lerp((character_direction * movement_speed), 0.08)
		else:
			velocity = velocity.lerp(Vector2.ZERO, 0.05)
	else:
		if character_direction:
			velocity = character_direction * movement_speed
		else:
			velocity = velocity.move_toward(Vector2.ZERO, movement_speed)
	
	if is_jumping:
		player_sprite.position = player_sprite.position.lerp((Vector2(0, -300)), 0.05)
	elif player_sprite.position.y < 0:
		player_sprite.position = player_sprite.position.lerp((Vector2(0, 300)), 0.045)
	
	if is_above_pit and not is_jumping and not is_on_cadle_block:
		fall()
		print("fall")
	
	gun_rotation_pivot.look_at(get_global_mouse_position())
	
	gun_rotation_pivot.rotate(deg_to_rad(-90))
	
	move_and_slide()


func _on_player_jump_time_over() -> void:
	is_jumping = false
	player_jump_time.stop()
	player_fall_time.start()


func _on_area_2d_area_exited(_area: Area2D) -> void:
	is_on_cadle_block = false
	reparent(get_tree().current_scene, true)


func _on_cradle_block(area: Area2D) -> void:
	is_on_cadle_block = true
	call_deferred("reparent", area, true)
	#reparent(area, true)


func _on_player_jump_time_down_timeout() -> void:
	is_on_ground = true
	area_cradles.monitoring = true
	area_pit.monitoring = true
	player_fall_time.stop()


func _above_pit(_area: Area2D) -> void:
	is_above_pit = true
	print("is above pit")


func _not_above_pit(_area: Area2D) -> void:
	is_above_pit = false
	print("is not above pit")
