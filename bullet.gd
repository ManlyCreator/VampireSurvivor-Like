extends Area2D


@export var speed: float = 1000.0
@export var maxDistance: float = 1200.0

var travelledDistance: float = 0


func _physics_process(delta: float) -> void:
	var dir: Vector2 = Vector2.RIGHT.rotated(rotation)
	
	position += dir * speed * delta
	travelledDistance += speed * delta
	
	if travelledDistance > maxDistance:
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("takeDamage"):
		body.takeDamage()
