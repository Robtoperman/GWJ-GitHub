extends CharacterBody2D

var direction : Vector2 = Vector2(0, 1)
var speed : float = 0.0
var life_time : float = 0.0


func _ready() -> void:
	if life_time:
		$BulletLifeTime.wait_time = life_time
		
		$BulletLifeTime.start()


func _physics_process(delta: float) -> void:
	global_position += direction.rotated(get_parent().rotation) * speed * delta

	move_and_slide()


func _on_bullet_life_time_timeout() -> void:
	queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		body.die()
	else:
		queue_free()
