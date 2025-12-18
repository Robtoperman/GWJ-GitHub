extends Node2D

var bullet_scene : PackedScene = preload("res://scenes/level_mechanics/bullet.tscn")

@onready var bullet_spawn_point: Node2D = $BulletSpawnPoint

@export var fire_rate : float = 1.0
@export var bullet_speed : float = 300.0
@export var bullet_life_time : float = 2.0
@export var small_bullet_life_life : float = 2.0
#@export_enum("Left and Right", "Up and Down") var split_direction: String
var split_direction: String = "Up and Down"


func spawn_bullet():
	var bullet = bullet_scene.instantiate()
	bullet.speed = bullet_speed
	bullet.position = bullet_spawn_point.position
	bullet.life_time = bullet_life_time
	#bullet.small_bullet_life_lite = small_bullet_life_life
	bullet.split_direction = split_direction
	bullet.position = $BulletSpawnPoint.position
	add_child(bullet)


func _ready() -> void:
	$ShootTimer.wait_time = fire_rate
	
	$ShootTimer.start()
	
	spawn_bullet()


func _on_bullet_spawn_timeout() -> void:
	spawn_bullet()
