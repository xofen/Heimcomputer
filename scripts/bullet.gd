extends Area2D


var travel_distance = 0

func _physics_process(delta):
	const SPEED = 140
	const RANGE = 200
	
	var direction = Vector2.RIGHT.rotated(rotation)
	
	position += direction * SPEED * delta
	
	travel_distance += SPEED * delta
	
	if travel_distance >= RANGE:
		queue_free()


func _on_body_entered(body):
	queue_free()
	
	if body.is_in_group("Enemies"):
		body.take_damege()

