class_name Mob extends CharacterBody2D

@export var health : int = 0
@export var damage : int = 0
@export var speed : int = 0
@export var target : Node2D = null

#signal hit_player(damage : int)

func test():
	print("printing from mob")

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
