extends CharacterBody2D

var speed : float = 450.0
var direction : Vector2 = Vector2.ZERO


func _physics_process(_delta: float) -> void:
	velocity = direction * speed
	
	move_and_slide()


func _slime_hit_top(_area: Area2D) -> void:
	print("Slime hit top")
	direction = Vector2(0, 1)


func _slime_hit_left(_area: Area2D) -> void:
	print("Slime hit left")
	direction = Vector2(1, 0)


func _slime_hit_right(_area: Area2D) -> void:
	print("Slime hit right")
	direction = Vector2(-1, 0)


func _slime_hit_bottom(_area: Area2D) -> void:
	print("Slime hit bottom")
	direction = Vector2(0, -1)
