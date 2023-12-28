extends CharacterBody2D


@onready var sprite2d = $AnimatedSprite2D
@onready var player = get_node("/root/GameBoard/Player") 
@onready var game_maneger = get_node("/root/GameBoard/GameManeger")


var health = 7
var can_move = true


func _physics_process(delta):
	if can_move and player:
		var direction = global_position.direction_to(player.global_position)
		velocity = direction * 1 / delta
		move_and_slide()


	#---   CHANGE ANIMATION
	if (velocity.x > 1 or velocity.x < -1 or velocity.y > 1 or velocity.y < -1):
		sprite2d.animation = "walk"
	else:
		sprite2d.animation = "death"
#-----					-----


	#---   FLIP ANIMATION
	if velocity.x == 0:
		return
	
	var is_left = velocity.x < 0
	sprite2d.flip_h = is_left
#-----					-----


func take_damege():
	health -= 1
	
	if health <= 0:
		can_move = false
		velocity = Vector2(0, 0)


func _on_animated_sprite_2d_animation_finished():
	queue_free()


func _on_tree_exited():
	game_maneger.add_point()

