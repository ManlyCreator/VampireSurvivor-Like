extends CharacterBody2D


const SMOKE: PackedScene = preload("res://smoke_explosion/smoke_explosion.tscn")
const STAR: PackedScene = preload("res://star.tscn")

@export var speed: float = 300.0
@export var health: float = 100.0

@onready var player: CharacterBody2D = $/root/Game/Player


func _ready() -> void:
	$Slime.play_walk()


func _physics_process(delta: float) -> void:
	var dir: Vector2 = global_position.direction_to(player.global_position)
	
	velocity = dir * speed
	
	move_and_slide()


func takeDamage() -> void:
	health -= 10
	
	if health <= 0:
		var smoke: Node2D = SMOKE.instantiate()
		smoke.position = global_position
		$/root/Game.add_child(smoke)
		
		var star: Node2D = STAR.instantiate()
		star.position = global_position
		$/root/Game.add_child(star)
		
		queue_free()
	
	$Slime.play_hurt()
