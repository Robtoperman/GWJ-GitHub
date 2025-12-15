extends Node2D

@export var fire_cool_down : float = 3
@onready var timer: Timer = $BulletSpawn
@export var bullet_life_time : float = 10
var bullet = preload("res://scenes/level_mechanics/bullet.tscn")


func _ready() -> void:
	timer.start()
	timer.wait_time = fire_cool_down


func _on_bullet_spawn_timeout() -> void:
	var bullet_instance = bullet.instantiate()
	bullet_instance.bullet_life_time = bullet_life_time
	add_child(bullet_instance)
