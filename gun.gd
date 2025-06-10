extends Area2D


const BULLET: PackedScene = preload("res://bullet.tscn")


func _physics_process(delta: float) -> void:
	var enemies: Array[Node2D] = get_overlapping_bodies()
	
	if enemies.size() > 0:
		var target: CharacterBody2D = enemies[0]
		look_at(target.global_position)


func shoot():
	var bullet: Area2D = BULLET.instantiate()
	
	bullet.position = %Barrel.global_position
	bullet.rotation = %Barrel.global_rotation
	%Barrel.add_child(bullet)


func _on_timer_timeout() -> void:
	if get_overlapping_bodies().size() > 0:
		shoot()
