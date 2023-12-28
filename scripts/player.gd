extends CharacterBody2D


@onready var sprite2d = $AnimatedSprite2D


signal health_depleted


var health = 9
var health_check = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]

var can_move = true

func _physics_process(delta):
	#---   CHANGE DIRECTIONS
	if can_move:
		var direction = Input.get_vector("m_left", "m_right", "m_up", "m_down")
		velocity = direction * 10 / delta
		move_and_slide()
#-----					-----

	const DAMAGE_RATE = 1
	var overlapping_mobs = %HurtBox.get_overlapping_bodies() 
	
	
	if overlapping_mobs.size() > 0:
		health -= DAMAGE_RATE * overlapping_mobs.size() * delta
		if health <= 0:
			can_move = false
			velocity = Vector2(0, 0)
			health_depleted.emit()
	
	
	for tick in health_check:
		if round(health) == tick:
			$HealthBar.frame = tick
	
	
	#---   CHANGE ANIMATION
	if (velocity.x > 1 or velocity.x < -1 or velocity.y > 1 or velocity.y < -1):
		sprite2d.animation = "walk"
	elif health <= 0:
		sprite2d.animation = "death"
	else:
		sprite2d.animation = "idle"
#-----					-----



	#---   FLIP ANIMATION
	if velocity.x == 0:
		return
	
	var is_left = velocity.x < 0
	sprite2d.flip_h = is_left
#-----					-----




func _on_animated_sprite_2d_animation_finished():
	remove_child(%player_sight)

