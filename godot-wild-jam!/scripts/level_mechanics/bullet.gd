extends CharacterBody2D

var direction : Vector2 = Vector2(0, 1)
var movement_speed : float = 300.0
@export var bullet_life_time : float = 5

@onready var timer: Timer = $BulletLifeTime


func _ready() -> void:
	timer.start()
	timer.wait_time = bullet_life_time
	

func _physics_process(delta: float) -> void:
	
	velocity = movement_speed * direction

	move_and_slide()


func _on_bullet_life_time_timeout() -> void:
	queue_free()
