extends Mob

@onready var sprite: Sprite2D = $Sprite2D

func _physics_process(delta):
	if target:
		var direction = (target.global_position - global_position).normalized()
		flip_sprite(direction)
		move_towards_player(direction)

func move_towards_player(direction) -> void:
	velocity = direction * speed
	move_and_slide()
	
func flip_sprite(direction):
	sprite.set_flip_h(is_player_left(direction))
	sprite.set_flip_v(not is_player_down(direction))

func _on_Enemy_body_entered(body:Node):
	print("hit ",body)
	


func _on_player__on_enemy_body_entered(body):
	pass # Replace with function body.
