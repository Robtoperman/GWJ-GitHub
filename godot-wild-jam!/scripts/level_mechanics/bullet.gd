extends CharacterBody2D

@onready var small_bullet_scene : PackedScene = preload("res://scenes/level_mechanics/small_bullet.tscn")

var split_direction : String = "Left and Right"
var life_time : float = 2.0
var direction : Vector2 = Vector2(0, 1)
var speed : float = 300.0


# On life time done, destory this bullet and spawn the two smaller ones
func explode():
	# Spawn the two smaller bullets
	var left_small_bullet = small_bullet_scene.instantiate()
	left_small_bullet.speed = speed
	left_small_bullet.life_time = life_time
	left_small_bullet.position = position
	
	if split_direction == "Left and Right":
		left_small_bullet.direction = direction.rotated(deg_to_rad(90))
	else:
		left_small_bullet.direction = direction.rotated(deg_to_rad(180))
		
	get_parent().add_child(left_small_bullet)
	
	var right_small_bullet = small_bullet_scene.instantiate()
	right_small_bullet.speed = speed
	right_small_bullet.life_time = life_time
	right_small_bullet.position = position
	
	if split_direction == "Left and Right":
		right_small_bullet.direction = direction.rotated(deg_to_rad(-90))
	else:
		right_small_bullet.direction = direction.rotated(deg_to_rad(0))
		
	get_parent().add_child(right_small_bullet)
	
	queue_free()


func _ready() -> void:
	if life_time:
		$BulletLifeTime.wait_time = life_time
		
		$BulletLifeTime.start()


func _physics_process(delta: float) -> void:
	global_position += direction.rotated(get_parent().rotation) * speed * delta
	
	move_and_slide()


func _on_bullet_life_time_timeout() -> void:
	explode()
