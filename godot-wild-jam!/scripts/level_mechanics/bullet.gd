extends CharacterBody2D

@onready var small_bullet_scene : PackedScene = preload("res://scenes/level_mechanics/small_bullet.tscn")

var split_direction : String = "Left and Right"
var life_time : float = 2.0
var small_bullet_life_time : float = 2.0
var direction : Vector2 = Vector2(0, 1)
var speed : float = 300.0
var speed_factor : float = speed / 2


# When the life time runs out, destory this bullet and spawn the two smaller ones in oposing directions
func explode():
	# Spawn the two smaller bullets
	
	#region Left Small Bullet
	var left_small_bullet = small_bullet_scene.instantiate()
	left_small_bullet.speed = speed_factor
	left_small_bullet.life_time = life_time
	left_small_bullet.position = position
	
	# Rotates the direction vector of the smaller bullets
	if split_direction == "Left and Right":
		left_small_bullet.direction = direction.rotated(deg_to_rad(90))  # Goes left
	else:
		left_small_bullet.direction = direction.rotated(deg_to_rad(180)) # Goes Up
		
	get_parent().add_child(left_small_bullet)
	#endregion
	
	#region Right Small Bullet
	var right_small_bullet = small_bullet_scene.instantiate()
	right_small_bullet.speed = speed_factor * 4
	right_small_bullet.life_time = life_time
	right_small_bullet.position = position
	
	# Rotates the direction vector of the smaller bullets
	if split_direction == "Left and Right":
		right_small_bullet.direction = direction.rotated(deg_to_rad(-90))  # Goes Right
	else:
		right_small_bullet.direction = direction.rotated(deg_to_rad(0))  # Goes Down
		
	get_parent().add_child(right_small_bullet)
	#endregion
	
	queue_free()


func _ready() -> void:
	if life_time:
		$BulletLifeTime.wait_time = life_time
		
		$BulletLifeTime.start()


func _physics_process(delta: float) -> void:
	# This moves the bullet forward while ensuring it's rotated the same way as the cannon
	global_position += direction.rotated(get_parent().rotation) * speed * delta
	
	move_and_slide()


func _on_bullet_life_time_timeout() -> void:
	explode()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		body.die()
	else:
		explode()
