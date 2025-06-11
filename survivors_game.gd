extends Node2D

const MAX_MOBS: int = 1
const MOB: PackedScene = preload("res://slime.tscn")

var numMobs: int = 0

func spawnMob():
	var mob: CharacterBody2D = MOB.instantiate()
	
	%PathFollow2D.progress_ratio = randf()
	mob.position = %PathFollow2D.global_position
	
	mob.mobKilled.connect(_on_mob_killed)
	add_child(mob)
	
	numMobs += 1


func _on_timer_timeout() -> void:
	if numMobs < MAX_MOBS:
		spawnMob()


func _on_player_health_depleted() -> void:
	%GameOver.visible = true
	get_tree().paused = true

func _on_mob_killed() -> void:
	numMobs -= 1
