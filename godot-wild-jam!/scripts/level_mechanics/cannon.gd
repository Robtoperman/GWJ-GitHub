extends Node2D

var bullet_scene : PackedScene = preload("res://scenes/level_mechanics/bullet.tscn")

@export var fire_rate : float = 1.0
@export var bullet_speed : float = 300.0
@export var bullet_life_time : float = 2.0
@export_enum("Left and Right", "Up and Down") var split_direction: String


func _ready() -> void:
	$ShootTimer.wait_time = fire_rate
	
	$ShootTimer.start()


func _on_bullet_spawn_timeout() -> void:
	var bullet = bullet_scene.instantiate()
	bullet.speed = bullet_speed
	bullet.life_time = bullet_life_time
	bullet.split_direction = split_direction
	bullet.position = $BulletSpawnPoint.position
	add_child(bullet)
