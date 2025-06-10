extends Area2D


func _physics_process(delta: float) -> void:
	var time: float = Time.get_unix_time_from_system()
	
	%Star.position.y = %Star.position.y + sin(time * 4.0) * 0.5


func _on_body_entered(body: Node2D) -> void:
	print(body)
	body.collectStar()
	queue_free()
