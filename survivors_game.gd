extends Node2D


const MOB: PackedScene = preload("res://slime.tscn")


func spawnMob():
	var mob: CharacterBody2D = MOB.instantiate()
	
	%PathFollow2D.progress_ratio = randf()
	mob.position = %PathFollow2D.global_position
	
	add_child(mob)


func _on_timer_timeout() -> void:
	spawnMob()


func _on_player_health_depleted() -> void:
	%GameOver.visible = true
	get_tree().paused = true
