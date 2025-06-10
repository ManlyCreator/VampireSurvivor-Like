extends CharacterBody2D


signal healthDepleted

const DAMAGE_RATE = 10.0

@export var speed: float = 500.0
@export var health: float = 100.0

# TODO: Cap enemy spawns to a certain amount
# TODO: Impulse on enemy when shot (backwards acceleration)
# TODO: Add an extra gun on each level up


func _physics_process(delta: float) -> void:
	var dir: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	velocity = dir * speed
	
	move_and_slide()
	
	if velocity.length() > 0:
		%HappyBoo.play_walk_animation()
	else:
		%HappyBoo.play_idle_animation()
	
	health -= DAMAGE_RATE * delta * %HurtBox.get_overlapping_bodies().size()
	
	%HealthBar.value = health
	
	if health <= 0:
		healthDepleted.emit()

func collectStar() -> void:
	%ProgressBar.value += 10
	if %ProgressBar.value == 100:
		%ProgressBar.value = 0
		# TODO: Implement extra gun here
