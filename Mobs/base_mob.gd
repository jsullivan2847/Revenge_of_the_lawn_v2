class_name Mob extends CharacterBody2D

@export var health : int = 0
@export var damage : int = 0
@export var speed : int = 0
@onready var sprite: Sprite2D = $Sprite2D
var target

func _ready():
	target = get_parent().get_node("Player")

func _physics_process(_delta):
	if get_modulate() != Color(1,1,1,1):
		set_modulate(Color(1,1,1,1))
	target = get_node("/root/Game/Player")
	if target:
		var direction = (target.global_position - global_position).normalized()
		flip_sprite(direction)
		move_towards_player(direction)
	else: 
		print('cant find')
	
func flip_sprite(direction):
	sprite.set_flip_h(is_player_left(direction))
	sprite.set_flip_v(not is_player_down(direction))

func move_towards_player(direction) -> void:
	velocity = direction * speed
	move_and_slide()


func is_player_left (direction) -> bool:
	if(direction):
		if direction.x < 0:
			return true
		else: return false
	else: return false
	
func is_player_down (direction) -> bool:
	if(direction):
		if direction.y < 0:
			return true
		else: return false
	else: return false

func _process(delta):
	if health <= 0:
		queue_free()
