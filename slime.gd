extends CharacterBody2D


signal mobKilled

const SMOKE: PackedScene = preload("res://smoke_explosion/smoke_explosion.tscn")
const STAR: PackedScene = preload("res://star.tscn")
const IMPULSE_FORCE: float = 400.0
const IMPULSE_DECEL: float = 400.0

@export var speed: float = 300.0
@export var health: float = 100.0

@onready var player: CharacterBody2D = $/root/Game/Player

var accelerating: bool = false
var impulseDir: Vector2 = Vector2.ONE
var impulseVel: Vector2 = Vector2.ZERO


func _ready() -> void:
	$Slime.play_walk()


func _physics_process(delta: float) -> void:
	var dir: Vector2 = global_position.direction_to(player.global_position)
	
	velocity = dir * speed + impulseVel

	impulseVel = clamp(impulseVel - impulseDir * IMPULSE_DECEL * delta, Vector2.ZERO, impulseDir * IMPULSE_FORCE)

	move_and_slide()


func takeDamage(dir: Vector2) -> void:
	health -= 25.0
	
	impulseDir = dir.normalized()
	impulseVel = impulseDir * IMPULSE_FORCE
	#if dir.dot(Vector2.RIGHT) < 0.0: 
		#impulseDir *= -1.0
	print(impulseDir)
	
	if health <= 0:
		var smoke: Node2D = SMOKE.instantiate()
		smoke.position = global_position
		$/root/Game.add_child(smoke)
		
		var star: Node2D = STAR.instantiate()
		star.position = global_position
		$/root/Game.add_child(star)
		
		mobKilled.emit()
		
		queue_free()
	
	$Slime.play_hurt()
